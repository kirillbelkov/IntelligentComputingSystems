Программа реализует простую нечеткую экспертную систему для оценки риска перегрева компьютера.
Система анализирует два параметра:
- температуру процессора;
- загрузку процессора.
На основе введенных значений программа определяет уровень риска перегрева:
- низкий;
- средний;
- высокий;
- критический.

Программа использует функции принадлежности для оценки входных данных. Затем применяются правила экспертной системы, после чего выполняется дефаззификация — перевод нечеткого результата в итоговый процент риска.

Примеры работы:
![result1](https://github.com/kirillbelkov/IntelligentComputingSystems/blob/main/lab3/3lab.png)
![result2](https://github.com/kirillbelkov/IntelligentComputingSystems/blob/main/lab3/3lab2.png)
![result3](https://github.com/kirillbelkov/IntelligentComputingSystems/blob/main/lab3/3lab3.png)
