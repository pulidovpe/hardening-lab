#!/bin/bash
B="openscap/dia1/resultado-baseline.xml"
F="openscap/dia4/resultado-post.xml"
[ -f openscap/dia4/final/resultado-final.xml ] && F="openscap/dia4/final/resultado-final.xml"
SP=$(grep -oP 'score.*?\K[0-9]+\.[0-9]+' $B | head -1)
SF=$(grep -oP 'score.*?\K[0-9]+\.[0-9]+' $F | head -1)
PP=$(grep -c 'result>pass' $B)
PF=$(grep -c 'result>pass' $F)
FP=$(grep -c 'result>fail' $B)
FF=$(grep -c 'result>fail' $F)
echo "=== REPORTE CIS Level 1 — Ubuntu 24.04 ==="
echo "Fecha: $(date +%Y-%m-%d)"
echo "SCORE: $SP% → $SF%"
echo "PASS: $PP → $PF (+$((PF-PP)))"
echo "FAIL: $FP → $FF (-$((FP-FF)))"
echo "Controles remediados: $((FP-FF))"
