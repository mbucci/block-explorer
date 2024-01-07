import logging
from datetime import datetime

from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

from app.api.router import router
from app.errors import BadRequest, BlockExplorerException, NotFound


app = FastAPI()

log = logging.getLogger()


@app.exception_handler(BlockExplorerException)
async def base_exc_handler(request: Request, exc: BlockExplorerException):
    return JSONResponse(status_code=500, content={"error": str(exc)})


@app.exception_handler(BadRequest)
async def base_exc_handler(request: Request, exc: BlockExplorerException):
    return JSONResponse(status_code=400, content={"error": str(exc)})


@app.exception_handler(NotFound)
async def base_exc_handler(request: Request, exc: BlockExplorerException):
    return JSONResponse(status_code=404, content={"error": str(exc)})


@app.get("/health")
def health_check():
    return {"timestamp": datetime.now().isoformat()}


app.include_router(router)
