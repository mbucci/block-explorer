class BlockExplorerException(Exception):
    """Base Block Explorer App Exception"""


class BadRequest(BlockExplorerException):
    """Bad Request"""


class NotFound(BlockExplorerException):
    """Something wasn't found"""
