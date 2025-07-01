# Tumorboards 
Die Vision eines zukünftigen Tumorboards.
Datenquellen und -flüsse werden simuliert.
Einschränkungen eines Krankenhauses werden teilweise ignoriert, z.B. durch die Anwendung von OpenAI-Modellen.
Tumorboards = Info vor Tumorboard + Info im Tumorboard = Tumorboardempfehlung. Info im Tumorboard sollte so wenig wie nötig sein.

SNOMED
Referenzen auf TNM-Atlas, WHO Classification of Tumors usw.
Tumorboard dokumentation passiert außer Orbis.
KI Ansatz 1: Es fehlt vordefinierte Informationen um einen Tumorboard durchzuführen. Kluger als ob etwas im Feld steht oder nicht.
    "Es ist X-Karzinom" "Der Bericht vom Immu ist schon raus" aber nicht angekommen.

KI Ansatz 2: Hier sind 5 Aussagen von Büchern, die mit der Therapieauswahl helfen sollten.
KI Ansatz 3: SNOMED codes können dynamisch generiert z.B. beim Freitext eintippen
KI Ansatz 4: KI-Pathologin stellt Fragen zum Fall an Anderen; Frage die nicht aus den bestehenden Informationen beantwortet können. Liste von 5, die Pathologin stellen kann oder nicht.
    "Irgendjemand hatte zu dem Resektion Fragen."
    "Haben wir X?" "Nein wir haben den Tumor nicht."
    "Warum war X nicht gemacht?" "Wir haben es eingeschränkt, weil wir zu wenig Gewebe hatten."
KI Ansatz 5: Vorschläge in "Tumorboardempfehlung" live als Auswahloptionen generieren (neben KI Ansatz 3). Verwendung von Codes oder konsistente Sprache.
KI Ansatz 6: Das live Abfragen von anderen Berichten / Tumorboard Informationen.
    "Was war das X-Ergebnis von dem Radiologie-Bericht?"
    "Gibt es Marken? "Ja, wir haben X und die Ergebnisse sind Y und Z. Halt! Ich bin falsch. Ich habe den falschen Befund gelesen."
    "Ist der Haupttumor raus?"

KI Ansatz 5: KI hilft mit sauberen Eingabedaten, um weniger KI in der Zukunft zu benötigen.
Challenge: Diagnose außerhlb vom Tool automatisch als 'aktuelle Diagnose' einfügen.
Patho -> Tumorboard: Vordefinierte Erkrankungsinformationen automatisch.
 

### TODO
- Erkünde PDF-Parser-Option
- Erstelle Formular in Jupyter Notebooks

### Workflow
Tumormeldung