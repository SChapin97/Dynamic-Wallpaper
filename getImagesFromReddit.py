#!/bin/python3

import praw
import random
import requests
import re
import os
from PIL import Image

REDDIT = praw.Reddit("bot1", user_agent="Post Scraper")
IMAGE_FORMATS = ["jpeg", "jpg", "png"]
SUBREDDITS = ["raining", "cozyplaces", "fairytaleasfuck", "wallpaper", "wallpapers"]

def get_image():
    posts = []

    #subreddit = REDDIT.subreddit(random.choice(SUBREDDITS))
    for sub in SUBREDDITS:
        subreddit = REDDIT.subreddit(sub)
        for submission in subreddit.top("day", limit=10):
            for format in IMAGE_FORMATS:
                if format in submission.url:
                    posts.append(submission)

    for post in posts:
        download_image(post.url)


def download_image(url):
    image = requests.get(url).content
    image_found = re.search(r"\w+\.\w+$", url)
    if image_found:
        image_name = image_found.group()

        image_fullpath = os.path.join("/home/schapin/Scripts/Dynamic-Wallpaper/Images/", image_name)
        image_file = open(image_fullpath, "wb")
        image_file.write(image)
        image_file.close()

        if not isLandscapeImage(image_fullpath):
            os.remove(image_fullpath)


def isLandscapeImage(url):
    image = Image.open(url)
    if image.width > image.height:
        return True
    else:
        return False


get_image()
