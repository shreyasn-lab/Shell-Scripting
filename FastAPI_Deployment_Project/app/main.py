from fastapi import FastAPI

app = FastAPI()

@app.get("/app")
def root():
    return {"message": "FastAPI Deployment Works 🚀"}
