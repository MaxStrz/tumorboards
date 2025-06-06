from collections import defaultdict
from dataclasses import dataclass
import pymupdf

thoraxformkeys = {
    'title':'Thorax und Allgemeines Tumorboard',
    'datum':'Datum Vorstellung Tumorboard',
    'patientenname':'Name:',
    'patientengeburtstag':'Geb.-Datum'
}

@dataclass
class Element:
    name: str # e.g. title, datum, patientenname
    text: str # e.g. 'Thorax und Allgemeines Tumorboard'
    block: tuple = None
    is_bold: bool = False # fetter Text bedeutet relevante Datenelement

@dataclass
class Document:
    name: str
    datei_name: str = None
    aktuelle_diagnose: Element = None

    def pdf_bloeke_erstellen(self):
        bloeke = defaultdict()
        with pymupdf.open(self.datei_name) as doc:
            for i, page in enumerate(doc):
                bloeke[i+1] = page.get_text("blocks")
        self.bloeke = bloeke

    def find_element_in_blocks(self, anchor):
        anchor = anchor.lower()
        anchor_bloeke = []
        for page, bloeke in self.bloeke.items():
            for block in bloeke:
                if anchor in block[4].lower():
                    anchor_bloeke.append(block)
                    print("Block added to element")
        if len(anchor_bloeke) > 1:
            print(anchor_bloeke)
            raise Exception('Mehrfach dieses Elements im Dokument')
        elif len(anchor_bloeke) == 0:
            raise Exception(f'Kein Block mit {anchor} gefunden')

        else:
            return anchor_bloeke[0]

    def add_block_to_elements(self):
        for element in self.elements:
            element.block = self.find_element_in_blocks(element.text)
        