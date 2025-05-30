::python -m venv tbvenv
call tbvenv\Scripts\activate
call pip install -r requirements.txt
call python -m ipykernel install --user --name=tbvenv --display-name "Python (tbvenv)"