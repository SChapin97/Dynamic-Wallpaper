#!/bin/python3

import praw
import random
import requests
import re

REDDIT = praw.Reddit("bot1", user_agent="Post Scraper")
IMAGE_FORMATS = ["jpeg", "jpg", "png"]
SUBREDDITS = ["raining", "cozyplaces", "fairytaleasfuck", "outrun"] #wallpaper, wallpapers

def get_image():
    posts = []

    done = False
    subreddit = REDDIT.subreddit(random.choice(SUBREDDITS))
    for post in subreddit.top("day", limit=7):
        for format in IMAGE_FORMATS:
            if format in post.url:
                posts.append(post)

    download_image(posts[random.randint(0, len(posts))].url)


def download_image(url):
    image = requests.get(url).content
    image_type = re.search("\.\w+$", url)

    image_name = "image" + str(random.randint(0,9)) + ".png"
    if image_type:
    	image_name = "image" + str(random.randint(0,9)) + image_type.group()

    with open(image_name, "wb") as handler:
        	handler.write(image)



get_image()
