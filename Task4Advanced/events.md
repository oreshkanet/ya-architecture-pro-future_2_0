# Каталог доменных событий

## 1. События Patient Management

### 1.1. PatientRegistered

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Patient Management |
| **Семантика** | В системе зарегистрирован новый пациент. Подписчики могут привязать к нему счёт, кредит или обновить витрины аналитики. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `patientId`, `registeredAt`, `sourceOrganizationId`. |

### 1.2. AppointmentScheduled

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Patient Management |
| **Семантика** | Создана запись на приём. Используется для витрин загрузки и очередей. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `appointmentId`, `patientId`, `resourceId`, `scheduledAt`, `organizationId`. |

### 1.3. AppointmentCancelled

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Patient Management |
| **Семантика** | Запись на приём отменена. Подписчики корректируют аналитику и освобождают слоты. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `appointmentId`, `cancelledAt`. |

---

## 2. События Clinical Operations

### 2.1. VisitCompleted

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Clinical Operations |
| **Семантика** | Визит пациента завершён. Может инициировать последующие процессы (ИИ-обработка по правилам) и обновление витрин. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `visitId`, `patientId`, `completedAt`, `organizationId`, `resourceId`. |

### 2.2. ResourceBooked

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Clinical Operations |
| **Семантика** | Ресурс (врач, кабинет, оборудование) забронирован на слот. Для аналитики загрузки. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `resourceId`, `appointmentId` или `visitId`, `slotStart`, `slotEnd`, `organizationId`. |

---

## 3. События Accounts & Credits

### 3.1. CreditContractCreated

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Accounts & Credits |
| **Семантика** | Заключён кредитный договор. Витрина и отчётность обновляют метрики по кредитам. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `creditContractId`, `customerId`, `amount`, `currency`, `signedAt`. |

### 3.2. AccountOpened

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Accounts & Credits |
| **Семантика** | Открыт новый счёт клиента. Используется для аналитики по продуктам и витрин. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `accountId`, `customerId`, `openedAt`, `productCode`, `currency`. |

---

## 4. События Payments

### 4.1. PaymentReceived

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Payments |
| **Семантика** | Платёж успешно проведён. Обновление балансов, витрин и отчётности. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `paymentId`, `accountId`/`creditContractId`, `amount`, `currency`, `occurredAt`. |

### 4.2. PaymentFailed

| Поле | Описание |
|------|----------|
| **Контекст-источник** | Payments |
| **Семантика** | Платёж не прошёл (отклонён, таймаут и т.д.). Учёт просрочек и отчётность. |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `paymentId`, `accountId`/`creditContractId`, `amount`, `failureReasonCode`, `occurredAt`. |

---

## 5. События AI & Research

### 5.1. StudyCompleted

| Поле | Описание |
|------|----------|
| **Контекст-источник** | AI & Research |
| **Семантика** | Исследование завершено. Для клиники — доступ к результатам; для витрины — только агрегаты и метрики (без персональных медицинских данных). |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `researchJobId`, `completedAt`, `studyType`, `organizationId`. Без диагнозов и персональных данных в теле события для подписчиков аналитики. |

### 5.2. AIResultReady

| Поле | Описание |
|------|----------|
| **Контекст-источник** | AI & Research |
| **Семантика** | Результат ИИ готов к использованию в клинической системе. Витрина может учитывать только факт и метрики (объёмы, типы). |
| **Минимальный контракт** | `eventId`, `eventType`, `occurredAt`, `version`, `researchJobId`, `resultId`, `readyAt`, `resultType` (классификация без ПДн). Детали результата — только в защищённом канале для Clinical Operations. |

---

## 6. Общие поля контракта (все события)

Каждое событие должно содержать как минимум:

| Поле | Тип | Назначение |
|------|-----|------------|
| `eventId` | string (UUID) | Уникальный идентификатор события; идемпотентность у подписчиков. |
| `eventType` | string | Тип события (например, `PatientRegistered`, `CreditContractCreated`). |
| `occurredAt` | timestamp | Время наступления факта в источнике (UTC). |
| `version` | string | Версия контракта (например, `1.0`) для совместимости. |

---