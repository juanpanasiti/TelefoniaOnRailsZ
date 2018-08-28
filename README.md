# README
## Clases

### Admin
- access_level: integer
- email: string
- password: string

### DeviceModel
- mark: string
- device_name: string
- device_code: string
- accessories: string
- details: text
- type_sim: string
- specs_link: string
- slot_sd: boolean
- category: string
- band: string
- os: string

### Device
- device_model_id: integer
- imei: string
- line_id: integer
- is_personal: boolean
- state: string
- failure: string
- check_date: datetime
- details: text

### Internal
- name: string
- prefix: string
- number: string
- office_id: integer
- footNote: text
- kind: string
- aclaration: string
- service_required: string

### Line
- person_id: integer
- number: string
- has_inet: string
- state: string
- type_sim: string
- ~~has_sms_pack: boolean~~
- check_date: datetime
- notes: text
- bill_account: string
- ~~vpn_link: string~~
- ~~limit_offnet: integer~~
- clarification: string
- plan_id: bigint

### MailAccount
- email: string
- pass: string
- person_id: integer

### Office
- name: string
- parent_id: integer
- category: string

### Person
- name: string
- lastname: string
- dni: string
- alert: boolean
- footnote: text
- office_id: integer

### Plan
- name: string
- normal_price: decimal
- roaming: string
- onnet_pack: integer
- offnet_pack: integer
- sms_pack: integer
- inet_pack: string
- credit: decimal
- kind: string
- details: text

### Task
- name: string
- detail: text
- state: string
- type_task: string
- date_limit: datetime

### ~~BillHeader~~
- ~~name: string~~
- ~~short_name: string~~
- ~~order: integer~~
- ~~type_field: string~~
- ~~type_value: string~~

### <del> BillItem </del>
- <del>bill_header_id: integer
- <del>concept_id: string
- <del>concept_description: string
- <del>quantity_column: integer
