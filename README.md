# **MQTTBlaster**

## **Setup**

\-----------

Publisher HW\<----\>Broker HW\<-----\>Client HW

## **Usage of tool:**

\--------------------------

1.  Install MQTT Broker Implementation (SW) you want to test on a HW . (Broker
    HW in above diagram)

2.  Install MQTT Client SW on both "Publisher HW" and "Client HW"

3.  Download self-contained MQTTBlaster repo binary from below URLs to the
    "Publisher HW" running Ubuntu 18.04 or higher.

-   Qos0:
    [https://github.com/MQTTBlaster/MQTTBlaster/tree/master/mqtt-publisher-QOS0](%20https:/github.com/MQTTBlaster/MQTTBlaster/tree/master/mqtt-publisher-QOS0)

-   Qos1:
    <https://github.com/MQTTBlaster/MQTTBlaster/tree/master/mqtt-publisher-QOS1>

-   Qos2:
    <https://github.com/MQTTBlaster/MQTTBlaster/tree/master/mqtt-publisher-QOS2>

1.  Copy "stats-3.sh" to "Broker HW" at /usr/share/mqtt/. Make it executable.
    Add this directory to system path.

2.  Enable password less login from "Publisher HW" to "Broker HW" for root user.
    (may use ssh-copyid)

3.  Create few clients on "Client HW" subscribing for "topic/\#" messages.

4.  Note: On our test HW we had used 15 clients to stress the broker to 100%.
    This number could be different depending on HW/SW combinations.

    From "mqtt-publisher-QOS[x]" folder execute "./mqtt-publisher-QOS0"

    Ex: \~/mqtt/git-submit/mqttorg/MQTTBlaster/mqtt-publisher-QOS0\$
    ./mqtt-publisher-QOS0

5.  You can modify "mqtt-blaster.ini" present in "mqtt-publisher-QOS[x]"
    configure the tool for your environment.

6.  Or to change rate of message, or maximum messages to be sent to broker,
    server address, etc.

**Config File Parameter configuration Example (mqtt-blaster.ini)**  
--------------------------------------------------------------------------------------

[server]

ip = 127.0.0.1

  
[mqtt]

maxmsg = 1200

  
[method]

rate = 0

delay = 0.005

interval = 100

-   server.ip: ip address of Broker HW where the MQTT broker is running.

-   mqtt.maxmsg: maximum number of messages to send.

-   method.rate: this is use to tune message rate for various brokers under
    test. Rate can be "0" or "1".

-   Rate is '0': When 'rate' is set to '0' you can use 'delay' parameter to
    control the message rate. Lower the delay higher the message rate.  
    Lower limit for 'delay' for this program is '0.00005'. Any value of 'delay'
    below '0.00005' will have no effect on message rate. If, with 'rate' set to
    '0' and 'delay' set to its lowest limit of '0.00005', if rate of published
    messages is not enough to overwhelm Borker HW, 'rate' should be set to '1'.
    Check below:

-   Rate is '1': you can use 'delay' and 'interval' to increase message rate or
    tune the message rate.  
    With 'delay' set to some value, higher values for 'interval' will result in
    higher message rates.
