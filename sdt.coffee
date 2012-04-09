#
# sdt-js CoffeeScript library for the Signal Detection Theory (SDT)
#
# Copyright (c) 2012 William Högman <me@whn.se>
# Licensed under the MIT License, see LICENSE.TXT



# I ported this from some code I wrote earlier in R so it might look
# strange to someone who doesn't know R.

normal = jStat.normal

# Lets use the names from R
qnorm = normal.inv
dnorm = normal.pdf

dprime = (hr,far) -> qnorm(hr,0,1) - qnorm(far,0,1)
criteria = (hr,far) -> dnorm(qnorm(hr,0,1),0,1) / dnorm(qnorm(1-far,0,1),0,1)

# we are gonna export sdt
sdt = {}


from_rate = (hr,far) ->
        dprime: dprime(hr,far),
        criteria: criteria(hr,far),
        hr: hr,
        mr: 1 - hr,
        far: far,
        cr: 1 - far,
        yes: (hr + far) / 2
        no: ((1 - far) + (1 - hr)) / 2

fn = (obj) ->
        $.extend(obj,
                noise:  (x) -> dnorm(x,0,1),
                signal: (x) -> dnorm(x,obj.dprime,1),
                )



plot = (canvas,obj) ->
        space = jStat.seq(-3,5,100)
        $.plot($(canvas),
        [
                {
                        label: "Noise",
                        data: space.map((x) -> [x, obj.noise(x)])
                },
                {
                        label: "Signal+Noise"
                        data: space.map((x) -> [x, obj.signal(x)]),
                },
                {
                        label: "Criteria",
                        data: space.map((x) -> [qnorm(1-obj.far,0,1),x])
                }

        ],
        xaxis: (min: -3, max:6),
        yaxis: (min: 0, max: 0.4)
        )

@sdt = from_rate: from_rate, fn: fn, plot: plot
