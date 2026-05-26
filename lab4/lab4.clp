(deftemplate symptom
   (slot name))

(deftemplate diagnosis
   (slot problem)
   (slot advice))

(deffacts start-fact
   (start))


(deffunction ask-question (?text ?symptom-name)
   (printout t ?text " (¤ /­¥â): ")
   (bind ?answer (readline))

   (if (or (eq ?answer "¤ ") (eq ?answer "„ "))
      then
         (assert (symptom (name ?symptom-name)))
      else
         (if (or (eq ?answer "­¥â") (eq ?answer "¥â"))
            then
               TRUE
            else
               (printout t "Žè¨¡ª : ­ã¦­® ¢¢¥áâ¨ ¤  ¨«¨ ­¥â." crlf)
               (ask-question ?text ?symptom-name)
         )
   )
)

(defrule ask-user
   ?f <- (start)
   =>
   (retract ?f)

   (printout t crlf)
   (printout t " ªá¯¥àâ­ ï á¨áâ¥¬  ¤¨ £­®áâ¨ª¨ Š" crlf)
   (printout t "Žâ¢¥ç ©â¥ ­  ¢®¯à®áë: ¤  ¨«¨ ­¥â" crlf)
   (printout t crlf)

   (ask-question "Š®¬¯ìîâ¥à ­¥ ¢ª«îç ¥âáï?" no-power)
   (ask-question "Š®¬¯ìîâ¥à ¢ª«îç ¥âáï, ­® íªà ­ ç¥à­ë©?" black-screen)
   (ask-question "Š®¬¯ìîâ¥à á¨«ì­® èã¬¨â?" loud-noise)
   (ask-question "Š®¬¯ìîâ¥à á¨«ì­® ­ £à¥¢ ¥âáï?" overheating)
   (ask-question "Š®¬¯ìîâ¥à ¬¥¤«¥­­® à ¡®â ¥â?" slow-work)
   (ask-question "Š®¬¯ìîâ¥à ç áâ® § ¢¨á ¥â?" freezes)
   (ask-question "®ï¢«ï¥âáï á¨­¨© íªà ­?" blue-screen)
   (ask-question "¥â ¯®¤ª«îç¥­¨ï ª ¨­â¥à­¥âã?" no-internet)
   (ask-question "Š®¬¯ìîâ¥à á ¬ ¯¥à¥§ £àã¦ ¥âáï?" restarts)

   (assert (questions-done))
)

(defrule power-supply-problem
   (questions-done)
   (symptom (name no-power))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "à®¡«¥¬  á ¡«®ª®¬ ¯¨â ­¨ï")
         (advice "à®¢¥àìâ¥ ª ¡¥«ì ¯¨â ­¨ï, à®§¥âªã ¨ ¡«®ª ¯¨â ­¨ï.")))
)

(defrule monitor-problem
   (questions-done)
   (symptom (name black-screen))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "à®¡«¥¬  á ¬®­¨â®à®¬ ¨«¨ ¢¨¤¥®ª àâ®©")
         (advice "à®¢¥àìâ¥ ª ¡¥«ì ¬®­¨â®à , ¬®­¨â®à ¨ ¢¨¤¥®ª àâã.")))
)

(defrule overheating-problem
   (questions-done)
   (symptom (name overheating))
   (symptom (name loud-noise))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "¥à¥£à¥¢ ª®¬¯ìîâ¥à ")
         (advice "Žç¨áâ¨â¥ ª®¬¯ìîâ¥à ®â ¯ë«¨ ¨ ¯à®¢¥àìâ¥ á¨áâ¥¬ã ®å« ¦¤¥­¨ï.")))
)

(defrule virus-or-system-problem
   (questions-done)
   (symptom (name slow-work))
   (symptom (name freezes))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "‚®§¬®¦­ë ¢¨àãáë ¨«¨ ¢ëá®ª ï ­ £àã§ª  á¨áâ¥¬ë")
         (advice "à®¢¥àìâ¥ ª®¬¯ìîâ¥à  ­â¨¢¨àãá®¬ ¨ § ªà®©â¥ «¨è­¨¥ ¯à®£à ¬¬ë.")))
)

(defrule ram-problem
   (questions-done)
   (symptom (name freezes))
   (symptom (name blue-screen))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "‚®§¬®¦­ ï ¯à®¡«¥¬  á ®¯¥à â¨¢­®© ¯ ¬ïâìî")
         (advice "à®¢¥àìâ¥ ®¯¥à â¨¢­ãî ¯ ¬ïâì ¨ ãáâ ­®¢«¥­­ë¥ ¤à ©¢¥àë.")))
)

(defrule driver-problem
   (questions-done)
   (symptom (name blue-screen))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "à®¡«¥¬  á ¤à ©¢¥à ¬¨")
         (advice "Ž¡­®¢¨â¥ ¨«¨ ¯¥à¥ãáâ ­®¢¨â¥ ¤à ©¢¥àë ãáâà®©áâ¢.")))
)

(defrule internet-problem
   (questions-done)
   (symptom (name no-internet))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "à®¡«¥¬  á ¨­â¥à­¥â-á®¥¤¨­¥­¨¥¬")
         (advice "à®¢¥àìâ¥ à®ãâ¥à, á¥â¥¢®© ª ¡¥«ì ¨ ­ áâà®©ª¨ ¯®¤ª«îç¥­¨ï.")))
)

(defrule critical-overheating
   (questions-done)
   (symptom (name overheating))
   (symptom (name restarts))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Šà¨â¨ç¥áª¨© ¯¥à¥£à¥¢")
         (advice "‚ëª«îç¨â¥ ª®¬¯ìîâ¥à ¨ ¯à®¢¥àìâ¥ á¨áâ¥¬ã ®å« ¦¤¥­¨ï.")))
)

(defrule hard-drive-problem
   (questions-done)
   (symptom (name slow-work))
   (symptom (name restarts))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "‚®§¬®¦­ ï ¯à®¡«¥¬  á ¦¥áâª¨¬ ¤¨áª®¬ ¨«¨ SSD")
         (advice "à®¢¥àìâ¥ ¤¨áª á¯¥æ¨ «ì­®© ¯à®£à ¬¬®© ¨ á®åà ­¨â¥ ¢ ¦­ë¥ ¤ ­­ë¥.")))
)

(defrule print-diagnosis
   ?d <- (diagnosis (problem ?problem) (advice ?advice))
   =>
   (printout t crlf)
   (printout t "„¨ £­®§: " ?problem crlf)
   (printout t "‘®¢¥â: " ?advice crlf)
   (retract ?d)
)

(defrule no-diagnosis
   (questions-done)
   (not (diagnosis-found))
   =>
   (printout t crlf)
   (printout t "’®ç­ë© ¤¨ £­®§ ­¥ ­ ©¤¥­." crlf)
   (printout t "‘®¢¥â: ®¡à â¨â¥áì ª á¯¥æ¨ «¨áâã ¨«¨ ãâ®ç­¨â¥ á¨¬¯â®¬ë." crlf)
)
