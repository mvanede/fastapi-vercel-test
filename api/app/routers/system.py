from fastapi import APIRouter

from api.app import __version__

router = APIRouter(tags=["System"])


@router.get("/status")
def status():
    return {"ok": True, "version": __version__}
