import logging

def marocLogging(logger,debugLevel=logging.DEBUG):
    logger.setLevel(debugLevel)
    ch = logging.StreamHandler()
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)

