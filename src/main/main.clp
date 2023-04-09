(deftemplate tea
	(slot name)
    (slot price)
    (slot type)
)

(deftemplate rec-tea
    (slot name)
    (slot price)
    (slot type)
)

(deffacts init-tea
    (tea (name "Original Milk Tea") (price "21000") (type "Milk"))
    (tea (name "Caramel Milk Tea") (price "23000") (type "Milk"))
    (tea (name "Original Thai Tea") (price "28000") (type "Thai"))
    (tea (name "Authentic Thai Tea") (price "30000") (type "Thai"))
)

(reset)

;budget -> low and high
;type -> milk and thai
;budget low -> show all milk
;budget high -> type milk -> show all milk
;budget high -> type thai -> show all thai

(defrule budget-low
    (b-low)
    (tea (name ?name) (price ?price) (type ?type))
    (test (eq ?type "Milk"))
    => 
    (assert (rec-tea (name ?name) (price ?price) (type ?type)))
)

(defrule budget-high
    (b-high ?typeinput)
    (tea (name ?name) (price ?price) (type ?type))
    (test (eq ?type ?typeinput))
    => 
    (assert (rec-tea (name ?name) (price ?price) (type ?type)))
)

(defrule rec
	(start-rec ?budget ?type)
    => 
    (if (eq ?budget "low") then 
        (assert (b-low))
        (run)
	elif (eq ?budget "high") then 
        (assert (b-high ?type))
        (run)
	)    
)

(defquery get-tea
    (tea (name ?name) (price ?price) (type ?type))
)

(defquery get-rec-tea
    (rec-tea (name ?name) (price ?price) (type ?type))
)

(deffunction view-tea()
    (new main.Query)
    (printout t crlf)    
)

(deffunction add-tea()
	(bind ?teaname "")
    (while (< (str-length ?teaname) 7)
        (printout t "Input tea name [min 7 chars]: ")
        (bind ?teaname (readline))
    )
    (bind ?priceinput 0)
    (while (< ?priceinput 15000)
        (printout t "Input tea price [more than or equals 15000]: ")
        (bind ?priceinput (readline))
    )
    (bind ?typeinput 0)
    (while (and (neq (str-compare ?typeinput "Thai") 0) (neq (str-compare ?typeinput "Milk") 0) )
        (printout t "Input tea type [Milk|Thai]: ")
        (bind ?typeinput (readline))
    )
    (assert (tea (name ?teaname) (price ?priceinput) (type ?typeinput)))
	(printout t "Tea added." crlf)
)

(deffunction update-tea()
    (facts)
    (bind ?updateid "")
    (printout t "Input tea id to update: ")
    (bind ?updateid (read))

    (bind ?teaname "")
    (while (< (str-length ?teaname) 7)
        (printout t "Input tea name [min 7 chars]: ")
        (bind ?teaname (readline))
    )
    (bind ?priceinput 0)
    (while (< ?priceinput 15000)
        (printout t "Input tea price [more than or equals 15000]: ")
        (bind ?priceinput (readline))
    )
    (bind ?typeinput 0)
    (while (and (neq (str-compare ?typeinput "Thai") 0) (neq (str-compare ?typeinput "Milk") 0) )
        (printout t "Input tea type [Milk|Thai]: ")
        (bind ?typeinput (readline))
    )
        
    (modify ?updateid (name ?teaname) (price ?priceinput) (type ?typeinput))
    (facts)
	(printout t "Tea updated." crlf)
)

(deffunction delete-tea()
    (facts)
    (bind ?deleteid "")
    (printout t "Input tea id to delete: ")
    (bind ?deleteid (read))

    (retract ?deleteid)
    (facts)
	(printout t "Tea deleted." crlf)
)

(deffunction rec-tea()
	(printout t "Input budget [low|high]: ")
    (bind ?budgetinput (readline))
	(printout t "Input type [Milk|Thai]: ")
    (bind ?typeinput (readline))
    (assert (start-rec ?budgetinput ?typeinput))
    (run)
    (new main.GUI)
)

(bind ?home 0)
(while (neq ?home 6) 
  (while (or (< ?home 1) (> ?home 6)) do 
    (printout t crlf) 
    (printout t "JhatiMe" crlf) 
    (printout t "1. View Menu" crlf) 
    (printout t "2. Add Menu" crlf) 
    (printout t "3. Update Menu" crlf) 
    (printout t "4. Delete Menu" crlf) 
    (printout t "5. Recommend Tea" crlf) 
    (printout t "6. Exit" crlf) 
    (printout t ">> ") 
    (bind ?home (read))
   ) 
  (bind ?chs 0)
  (if (eq ?home 1) then 
    (printout t "View Menu" crlf) 
    (view-tea)
    (printout t crlf)    
  elif (eq ?home 2) then 
    (printout t "Add Menu" crlf) 
	(add-tea)
    (printout t crlf)    
  elif (eq ?home 3) then 
    (printout t "Update Menu" crlf) 
	(update-tea)
    (printout t crlf)    
  elif (eq ?home 4) then 
    (printout t "Delete Menu" crlf) 
	(delete-tea)
    (printout t crlf)    
  elif (eq ?home 5) then 
    (printout t "Recommend Tea" crlf)
    (rec-tea)
    (printout t crlf)    
  )
  (if (neq ?home 6) then (bind ?home 0))
)
