(ns suncalcs)

(def nsc (js/require "./noaa_suncalc"))

(console.log (.calculate_op nsc))

(deftype Loc [lat lon]
    Object
    (bar [this x] (+ x lat lon)))

(defn test1 [] "yo")
