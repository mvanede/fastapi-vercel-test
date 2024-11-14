from fastapi import FastAPI, Response

from .routers import system

app = FastAPI(root_path="/api")
app.include_router(system.router, prefix="/system")

@app.get("/")
def status():
    return Response(
            content="👋 Hi",
            media_type="application/json; charset=utf-8"
          )

@app.get("/foobar")
def status():
    return Response(
            content="👋 Foobar",
            media_type="application/json; charset=utf-8"
          )