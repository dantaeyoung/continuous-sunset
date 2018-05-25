(ns server.core
  (:require [cljs.nodejs :as nodejs]
            [suncalcs]))

; Bring in `express` and `http` modules.
(defonce express (nodejs/require "express"))
(defonce http (nodejs/require "http"))

; Create our app.
(def app (express))

(def t (suncalcs/Loc. 1 2))
(console.log (.bar t 4))

(let [mylat 40.7128 mylon 74.0060]
  (def myLoc (suncalcs/Loc. mylat mylon)))



;(console.log (suncalcs/test2))

; Mount GET handler.
(. app (get "/hello"
  (fn [req res] (. res (send (str (.bar myLoc 9)))))))

; Listen on port 3000.
(doto (.createServer http #(app %1 %2))
  (.listen 3000))





