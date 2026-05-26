def triangle(x, a, b, c):
    if x <= a or x >= c:
        return 0
    elif x == b:
        return 1
    elif a < x < b:
        return (x - a) / (b - a)
    else:
        return (c - x) / (c - b)


def trapezoid(x, a, b, c, d):
    if b <= x <= c:
        return 1
    elif x <= a or x >= d:
        return 0
    elif a < x < b:
        return (x - a) / (b - a)
    else:
        return (d - x) / (d - c)


def fuzzy_system(temperature, load):
    # Температура процессора
    temp_low = trapezoid(temperature, 0, 0, 30, 50)
    temp_normal = triangle(temperature, 35, 55, 75)
    temp_high = trapezoid(temperature, 65, 80, 100, 100)

    # Загрузка процессора
    load_low = trapezoid(load, 0, 0, 25, 45)
    load_medium = triangle(load, 30, 55, 80)
    load_high = trapezoid(load, 70, 85, 100, 100)

    # Низкий риск
    rule1 = min(temp_low, load_low)
    rule2 = min(temp_low, load_medium)
    rule3 = min(temp_normal, load_low)

    # Средний риск
    rule4 = min(temp_normal, load_medium)
    rule5 = min(temp_normal, load_high)
    rule6 = min(temp_high, load_low)

    # Высокий риск
    rule7 = min(temp_high, load_medium)

    # Критический риск
    rule8 = min(temp_high, load_high)

    # Объединение правил
    risk_low = max(rule1, rule2, rule3)
    risk_medium = max(rule4, rule5, rule6)
    risk_high = rule7
    risk_critical = rule8

    numerator = (
        risk_low * 20 +
        risk_medium * 50 +
        risk_high * 75 +
        risk_critical * 95
    )

    denominator = risk_low + risk_medium + risk_high + risk_critical

    if denominator == 0:
        final_risk = 0
    else:
        final_risk = numerator / denominator

    return final_risk, risk_low, risk_medium, risk_high, risk_critical


def get_number(text):
    while True:
        try:
            value = float(input(text))

            if 0 <= value <= 100:
                return value
            else:
                print("Ошибка: число должно быть от 0 до 100.")

        except ValueError:
            print("Ошибка: нужно ввести число.")


def print_result(risk, low, medium, high, critical):
    print("\nРезультат работы экспертной системы:")
    print("Низкий риск:", round(low, 2))
    print("Средний риск:", round(medium, 2))
    print("Высокий риск:", round(high, 2))
    print("Критический риск:", round(critical, 2))

    print("\nИтоговый риск:", round(risk, 2), "%")

    if risk < 35:
        print("Вывод: состояние компьютера нормальное.")
        print("Совет: ничего делать не нужно.")
    elif risk < 60:
        print("Вывод: есть средний риск перегрева.")
        print("Совет: закройте лишние программы.")
    elif risk < 85:
        print("Вывод: высокий риск перегрева.")
        print("Совет: уменьшите нагрузку и проверьте охлаждение.")
    else:
        print("Вывод: критический риск перегрева.")
        print("Совет: срочно выключите компьютер или дайте ему остыть.")

while True:
    print("\n===================================")
    print(" Нечеткая экспертная система")
    print(" Оценка риска перегрева компьютера")
    print("===================================")
    print("1 - Начать проверку")
    print("0 - Выход")

    choice = input("Выберите действие: ")

    if choice == "0":
        print("Программа завершена.")
        break

    elif choice == "1":
        temperature = get_number("Введите температуру процессора от 0 до 100: ")
        load = get_number("Введите загрузку процессора от 0 до 100: ")

        risk, low, medium, high, critical = fuzzy_system(temperature, load)

        print_result(risk, low, medium, high, critical)

    else:
        print("Ошибка: выберите 1 или 0.")
