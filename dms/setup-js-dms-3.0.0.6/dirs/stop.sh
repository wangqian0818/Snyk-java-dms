#!/bin/sh

ps -ef|grep dms-1.0.0-SNAPSHOT.jar|grep java| awk '{print $2}'|xargs kill -9
