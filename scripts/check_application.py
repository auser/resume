#!/usr/bin/env python3
"""Check generated resume content and layout structure; not a commercial ATS test."""
from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

from build_application import ROOT, load_profile, selected


def normalize(text: str) -> str:
    return " ".join(text.split())


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--profile", type=Path, default=ROOT / "application-profile.json")
    parser.add_argument("--out-dir", type=Path, default=ROOT / "build" / "application")
    parser.add_argument("--pdf", action="store_true", help="Require and check PDF using pdftotext and pdfinfo")
    args = parser.parse_args()
    try:
        data = load_profile(args.profile)
        out = args.out_dir.resolve()
        bullets = [b["text"] for j in data["experience"] for b in selected(j)]
        docx = out / "ari-lerner-resume-application.docx"
        ns = {"w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}
        with zipfile.ZipFile(docx) as archive:
            tree = ET.fromstring(archive.read("word/document.xml"))
            for tag in ["tbl", "drawing", "txbxContent", "pict"]:
                if tree.findall(f".//w:{tag}", ns):
                    raise ValueError(f"Unexpected document structure: {tag}")
            columns = tree.findall(".//w:cols", ns)
            number_attr = f"{{{ns['w']}}}num"
            if any(c.get(number_attr, "1") != "1" for c in columns):
                raise ValueError("Document has multiple columns")
            text = normalize(" ".join("".join(t.text or "" for t in paragraph.findall(".//w:t", ns)) for paragraph in tree.findall(".//w:p", ns)))
        for expected in [data["name"], *data["contact_lines"], *bullets]:
            if normalize(expected) not in text:
                raise ValueError(f"DOCX text missing: {expected}")
        letter = (out / "cover-letter-120-words.txt").read_text(encoding="utf-8")
        if len(letter.split()) != 120:
            raise ValueError("Exported cover letter is not 120 words")
        report = {"selected_bullets": len(bullets), "rewritten_bullets": sum(len(j["highlights"]) for j in data["experience"]), "cover_letter_words":120, "docx_text_complete":True, "docx_single_column":True, "docx_no_tables_drawings_or_textboxes":True, "commercial_ats_tested":False}
        if args.pdf:
            for executable in ["pdftotext", "pdfinfo"]:
                if not shutil.which(executable):
                    raise RuntimeError(f"Missing {executable}; install Poppler to check PDF text and metadata")
            pdf = out / "ari-lerner-resume-application.pdf"
            raw = subprocess.run(["pdftotext", str(pdf), "-"], capture_output=True, text=True, check=True, timeout=30).stdout
            pdf_text = normalize(raw)
            positions = []
            for b in bullets:
                position = pdf_text.find(normalize(b))
                if position < 0:
                    raise ValueError(f"PDF text missing: {b}")
                positions.append(position)
            if positions != sorted(positions):
                raise ValueError("PDF bullet reading order differs from the source profile")
            if any(0xE000 <= ord(char) <= 0xF8FF or char == "\ufffd" for char in raw):
                raise ValueError("PDF text contains a private-use or replacement character")
            metadata = subprocess.run(["pdfinfo", str(pdf)], capture_output=True, text=True, check=True, timeout=30).stdout
            match = re.search(r"^Pages:\s+(\d+)", metadata, re.MULTILINE)
            if not match or int(match.group(1)) != 2:
                raise ValueError("Expected a two-page application PDF")
            report.update(pdf_pages=2, pdf_text_complete=True, pdf_bullet_order_correct=True, pdf_no_private_use_or_replacement_characters=True)
        (out / "validation.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
        print(json.dumps(report, indent=2))
        return 0
    except (OSError, ValueError, KeyError, RuntimeError, zipfile.BadZipFile, ET.ParseError, subprocess.SubprocessError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
