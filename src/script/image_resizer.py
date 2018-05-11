#!/usr/bin/env python
from __future__ import print_function
import sys
import rospy
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

class image_resizer:

  def __init__(self):
    self.image_pub = rospy.Publisher("image_resized",Image, queue_size=10)

    self.bridge = CvBridge()
    self.image_sub = rospy.Subscriber("image_raw",Image,self.callback)

  def callback(self,data):
    try:
      cv_image = self.bridge.imgmsg_to_cv2(data, "bgr8")
      h = cv_image.shape[0]
      w = cv_image.shape[1]
      half_size = cv2.resize(cv_image, (w / 2, h / 2))
    except CvBridgeError as e:
      print(e)

    try:
      self.image_pub.publish(self.bridge.cv2_to_imgmsg(half_size, "bgr8"))
    except CvBridgeError as e:
      print(e)

def main(args):
  rospy.init_node('image_resizer', anonymous=True)
  print("Image Resizer Initialized")
  ic = image_resizer()
  try:
    rospy.spin()
  except KeyboardInterrupt:
    print("Shutting down")

if __name__ == '__main__':
    main(sys.argv)