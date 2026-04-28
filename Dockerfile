FROM gradle:8-jdk21-corretto AS build
WORKDIR /app

# Копіюємо лише файли конфігурації Gradle для кешування залежностей
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

# Завантажуємо залежності (це пришвидшить наступні збірки)
# Завантажуємо залежності без спроби зібрати відсутній код
RUN ./gradlew dependencies --no-daemon

# Копіюємо вихідний код і збираємо проєкт
COPY src src
RUN ./gradlew clean bootJar -x test --no-daemon

# --- Stage 2: Run ---
# Використовуємо мінімальний образ Amazon Corretto 21 для виконання
FROM amazoncorretto:21-al2023-headless
WORKDIR /app

# Використовуємо непривілейованого користувача за його числовим ID
USER 1001:1001

# Копіюємо тільки зібраний JAR-файл з попереднього етапу
COPY --from=build /app/build/libs/*.jar app.jar

ENV DB_URL=""
ENV DB_USER=""
ENV DB_PASS=""

ENTRYPOINT ["java", \
            "-Dspring.datasource.url=${DB_URL}", \
            "-Dspring.datasource.username=${DB_USER}", \
            "-Dspring.datasource.password=${DB_PASS}", \
            "-jar", "app.jar"]