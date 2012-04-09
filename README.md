sdt-js
======

sdt-js is a Javascript library for signal detection theory, written in
CoffeeScript. It is primarily intended for educational purposes, but
might be useful for other things as well.

Usage
=====
sdt.from_rate(hit_rate,false_alarm_rate) returns an object containing
several properties related to SDT. 

```javascript

        // sdt.from_rate(HitRate,FalseAlarmRate)
        var yourdata = sdt.from_rate(.9,.1) // implies miss=.1 and cr=.9
        // This returns
        {
            // Correct rejections
            cr: 0.9,
            
            // Misses 
            mr: 0.1,
            
            // Hits
            hr: 0.9,
            
            // False alarms
            far: 0.1,
            

            // beta and dprime
            dprime: 2.56,
            criteria: 1,
            
            // pr(no) and pr(yes) responses
            no: 0.5
            yes: 0.5

                
        }
        
        // You can then call
        sdt.fn(yourdata) //which extends yourdata with
        {
                signal: function(x) {...}
                noise: function(x) {...}
        }
        // sdt.plot uses these two functions for plotting
        

```


Building
========

To build sdt-js just run ./build.sh in a terminal. If you have the
yui-compressor installed on your system that it will be used to
generate a minified version.


Dependencies
============
The only hard dependency is [jstat](https://github.com/jstat/jstat)
which is used for the distribution functions. sdt.plot depends on
the flot library for drawing plots, which in turn depends jQuery.

In summary, if you want plots you need jstat, flot and jQuery, if
you just want to do the calculations you just need jstat.


Todo
=====

- Enable customization of sdt.plot
- Function that for any given d' generates N number of different
  criteria, and their corresponding hits and false alarms.
- Plotting the ROC curve for a given d'

Limitations 
=========== 

There are a number of limitations that you should be aware of, but
these won't matter for most use-cases.

- There are a few differences in how jstat calculates the gaussian
  distribution but in most cases this shouldn't matter.

- JavaScript _only_ supports IEEE 754 doubles, in R you can use
  libraries that enable more precise calculations. 
