from fastapi import FastAPI

from .config import app_config

app = FastAPI(**app_config)

@app.get('/')
async def root():
    return {'message': 'Hello world!!!~~~~~~'}


    