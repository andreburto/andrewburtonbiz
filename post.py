import logging
import sys

# Configure logger
logger = logging.getLogger(__file__)
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler(sys.stdout))


def lambda_handler(event, context):
    logger.info(f"Received event: {event}")
    logger.info(f"Context: {context}")
    return "OK"
