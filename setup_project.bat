::python -m venv tbvenv
::call tbvenv\Scripts\activate
pip install -r requirements.txt
python -m ipykernel install --user --name=tbvenv --display-name "Python (tbvenv)"

