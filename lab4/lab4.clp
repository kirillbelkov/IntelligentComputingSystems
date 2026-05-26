(deftemplate symptom
   (slot name))

(deftemplate diagnosis
   (slot problem)
   (slot advice))

(deffacts start-fact
   (start))


(deffunction ask-question (?text ?symptom-name)
   (printout t ?text " (да/нет): ")
   (bind ?answer (readline))

   (if (or (eq ?answer "да") (eq ?answer "Да"))
      then
         (assert (symptom (name ?symptom-name)))
      else
         (if (or (eq ?answer "нет") (eq ?answer "Нет"))
            then
               TRUE
            else
               (printout t "Ошибка: нужно ввести да или нет." crlf)
               (ask-question ?text ?symptom-name)
         )
   )
)

(defrule ask-user
   ?f <- (start)
   =>
   (retract ?f)

   (printout t crlf)
   (printout t " Экспертная система диагностики ПК" crlf)
   (printout t "Отвечайте на вопросы: да или нет" crlf)
   (printout t crlf)

   (ask-question "Компьютер не включается?" no-power)
   (ask-question "Компьютер включается, но экран черный?" black-screen)
   (ask-question "Компьютер сильно шумит?" loud-noise)
   (ask-question "Компьютер сильно нагревается?" overheating)
   (ask-question "Компьютер медленно работает?" slow-work)
   (ask-question "Компьютер часто зависает?" freezes)
   (ask-question "Появляется синий экран?" blue-screen)
   (ask-question "Нет подключения к интернету?" no-internet)
   (ask-question "Компьютер сам перезагружается?" restarts)

   (assert (questions-done))
)

(defrule power-supply-problem
   (questions-done)
   (symptom (name no-power))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Проблема с блоком питания")
         (advice "Проверьте кабель питания, розетку и блок питания.")))
)

(defrule monitor-problem
   (questions-done)
   (symptom (name black-screen))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Проблема с монитором или видеокартой")
         (advice "Проверьте кабель монитора, монитор и видеокарту.")))
)

(defrule overheating-problem
   (questions-done)
   (symptom (name overheating))
   (symptom (name loud-noise))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Перегрев компьютера")
         (advice "Очистите компьютер от пыли и проверьте систему охлаждения.")))
)

(defrule virus-or-system-problem
   (questions-done)
   (symptom (name slow-work))
   (symptom (name freezes))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Возможны вирусы или высокая нагрузка системы")
         (advice "Проверьте компьютер антивирусом и закройте лишние программы.")))
)

(defrule ram-problem
   (questions-done)
   (symptom (name freezes))
   (symptom (name blue-screen))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Возможная проблема с оперативной памятью")
         (advice "Проверьте оперативную память и установленные драйверы.")))
)

(defrule driver-problem
   (questions-done)
   (symptom (name blue-screen))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Проблема с драйверами")
         (advice "Обновите или переустановите драйверы устройств.")))
)

(defrule internet-problem
   (questions-done)
   (symptom (name no-internet))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Проблема с интернет-соединением")
         (advice "Проверьте роутер, сетевой кабель и настройки подключения.")))
)

(defrule critical-overheating
   (questions-done)
   (symptom (name overheating))
   (symptom (name restarts))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Критический перегрев")
         (advice "Выключите компьютер и проверьте систему охлаждения.")))
)

(defrule hard-drive-problem
   (questions-done)
   (symptom (name slow-work))
   (symptom (name restarts))
   =>
   (assert (diagnosis-found))
   (assert
      (diagnosis
         (problem "Возможная проблема с жестким диском или SSD")
         (advice "Проверьте диск специальной программой и сохраните важные данные.")))
)

(defrule print-diagnosis
   ?d <- (diagnosis (problem ?problem) (advice ?advice))
   =>
   (printout t crlf)
   (printout t "Диагноз: " ?problem crlf)
   (printout t "Совет: " ?advice crlf)
   (retract ?d)
)

(defrule no-diagnosis
   (questions-done)
   (not (diagnosis-found))
   =>
   (printout t crlf)
   (printout t "Точный диагноз не найден." crlf)
   (printout t "Совет: обратитесь к специалисту или уточните симптомы." crlf)
)