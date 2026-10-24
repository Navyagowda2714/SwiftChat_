"""Minimal WebSocket chat server for local testing of the SwiftChat iOS app.

Every message a client sends is broadcast to all connected clients.

    pip install websockets
    python server/chat_server.py          # listens on ws://localhost:8080
"""
import asyncio

import websockets

CLIENTS: set = set()


async def handler(websocket):
    CLIENTS.add(websocket)
    try:
        async for message in websocket:
            websockets.broadcast(CLIENTS, message)
    finally:
        CLIENTS.discard(websocket)


async def main(host: str = "0.0.0.0", port: int = 8080) -> None:
    async with websockets.serve(handler, host, port):
        print(f"SwiftChat server running on ws://localhost:{port}")
        await asyncio.Future()  # run forever


if __name__ == "__main__":
    asyncio.run(main())
