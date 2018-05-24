(ns server.core
  (:require
   [cljs.nodejs :as nodejs]))

; Bring in `express` and `http` modules.
(defonce express (nodejs/require "express"))
(defonce http (nodejs/require "http"))

; Create our app.
(def app (express))

; Mount GET handler.
(. app (get "/hello"
  (fn [req res] (. res (send "Hello world")))))

; Listen on port 3000.
(doto (.createServer http #(app %1 %2))
  (.listen 3000))

