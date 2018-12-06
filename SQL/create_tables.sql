create table PERSON(
Person_ID varchar(4) check(length(Person_ID)=4 and Person_ID like 'P%' and cast(substr(PersonID,2,3) as decimal)>=100 and cast(substr(PersonID,2,3) as decimal)<=999),
First_name varchar(50) not null,
Middle_name varchar(50),
Last_name varchar(50) not null,
Gender char(1) check(Gender in ('M','F','O')),
Address varchar(100) not null,
Date_Of_Birth date check(Date_of_Birth<=curdate()),
primary key(Person_ID)
); 
commit;

create table CONTACTS(
Person_ID varchar(4) not null,
Phone_number decimal(10) unique check(length(Phone_number)=10) ,
primary key(Person_ID,Phone_number),
foreign key(Person_ID) references PERSON(Person_ID)
on delete cascade on update cascade
);
commit;

create table NURSE(
Emp_ID varchar(4),
Start_date date not null check(Start_date<=curdate()),
primary key(Emp_ID),
foreign key(Emp_ID) references PERSON(Person_ID) on update cascade
);
commit;

create table DOCTOR(
Emp_ID varchar(4),
Start_date date not null check(Start_date<=curdate()),
Specilization varchar(20),
Doctor_type varchar(15) check(Doctor_role in ('Trainee','Permanent','Visiting')),
primary key(Emp_ID),
foreign key(Emp_ID) references PERSON(Person_ID) on update cascade
);
commit;

create table RECEPTIONIST(
Emp_ID varchar(4),
Start_date date not null check(Start_date<=curdate()),
primary key(Emp_ID),
foreign key(Emp_ID) references PERSON(Person_ID) on update cascade
);
commit;

create table CLASS1_PATIENT(
Patient_ID varchar(4) not null,
Date_of_appointment date not null check(Date_of_appointment<=curdate()),
Consult_doctor varchar(4) not null,
primary key(Patient_ID,Date_of_appointment),
foreign key(Patient_ID) references PERSON(Person_ID) on update cascade,
foreign key(Consult_doctor) references DOCTOR(Emp_ID) on update cascade
);
commit;

create table ROOM(
Room_ID varchar(5),
Nurse_ID varchar(4) not null,
Room_type varchar(10) not null,
start_date time check(start_date<=curdate()),
end_date time check(enddate>curdate()),
primary key(Room_ID),
foreign key(Nurse_ID) references NURSE(Emp_ID) on update cascade,
check(end_date>start_date)
);
commit;

create table CLASS2_PATIENT(
Patient_ID varchar(4),
Room_ID varchar(5) not null,
Admission_date date check(Admission_date<=curdate()),
primary key(Patient_ID,Admission_date),
foreign key(Patient_ID) references PERSON(Person_ID) on update cascade,
foreign key(Room_ID) references ROOM(Room_ID) on update cascade
);
commit;

create table CLASS2_PATIENT_CONSULTATION(
Patient_ID varchar(4) not null,
Admission_date date check(Admission_date<=curdate()),
Consult_doctor varchar(4) not null,
primary key(Patient_ID,Admission_date, Consult_doctor),
foreign key(Patient_ID,Admission_date) references CLASS2_PATIENT(Patient_ID,Admission_date),
foreign key(Consult_doctor) references DOCTOR(Emp_ID) on update cascade
);
commit;

create table RECORD(
Record_ID varchar(7),
Recetionist_ID varchar(4) not null,
Patient_ID varchar(4) not null,
Date_of_appointment date not null check(Date_of_appointment>=curdate()),
Date_of_visit date not null check(Date_of_visit>=curdate()),
Record_description varchar(200),
primary key(Record_ID),
foreign key(Patient_ID) references PERSON(Person_ID) on update cascade,
foreign key(Recetionist_ID) references RECEPTIONIST(Emp_ID) on update cascade
);
commit;

create table INSURANCE(
Insurance_ID varchar(10),
Provider varchar(30) not null,
Coverage decimal(10) not null,
Amount decimal(10) not null,
primary key(Insurance_ID)
);
commit;

create table PAYMENTS(
Patient_ID varchar(4),
Date_of_payment date not null check(Date_of_payment>=curdate()),
Recetionist_ID varchar(4) not null,
Insurance_ID varchar(10),
Amount_due decimal(10) not null check(Amount_due>=0),
Cash_amount decimal(10) not null default 0 check(Cash_amount>=0),
primary key(Patient_ID,Date_of_payment),
foreign key(Patient_ID) references PERSON(Person_ID),
foreign key(Recetionist_ID) references RECEPTIONIST(Emp_ID),
foreign key(Insurance_ID) references INSURANCE(Insurance_ID)
);
commit;

create table VISITOR(
Visitor_ID varchar(10),
Patient_ID varchar(4) not null,
Admission_date date,
Visitor_name varchar(30) not null,
Visitor_address varchar(50) not null,
Contact_info decimal(10),
primary key(Visitor_ID,Patient_ID, Admission_date),
foreign key(Patient_ID, Admission_date) references CLASS2_PATIENT(Patient_ID, Admission_date)
);
commit;


create table PHARMACY(
Medicene_code varchar(6),
Medicene_name varchar(20) not null,
Price decimal(10,2) not null check(Price>0),
Quantity decimal(4) not null check(Quantity>=0),
Date_of_expiry date not null check(Date_of_expiry>=curdate()),
primary key(Medicene_code)
);
commit;

create table TREATMENT(
Treatment_ID varchar(6),
Treatment_name varchar(20) not null,
Duration decimal(3,1) not null check(Duration_number>0),
Duration_unit varchar(10) not null check(Duration_unit in ('Months','Days','Years')),
primary key(Treatment_ID)
);
commit;

create table MEDICENE_ASSOC(
Treatment_ID varchar(6),
Medicene_code varchar(6),
primary key(Treatment_ID, Medicene_code),
foreign key(Treatment_ID) references TREATMENT(Treatment_ID),
foreign key(Medicene_code) references PHARMACY(Medicene_code)
);
commit;

create table TREATMENT_DETAILS(
Patient_ID varchar(4),
Admission_date date check(Admission_date<=curdate()),
Treatment_ID varchar(6),
Medicene_code varchar(6),
primary key(Patient_ID, Admission_date, Treatment_ID, Medicene_code),
foreign key(Patient_ID,Admission_date) references CLASS2_PATIENT(Patient_ID,Admission_date),
foreign key(Treatment_ID) references TREATMENT(Treatment_ID),
foreign key(Medicene_code) references PHARMACY(Medicene_code)
);
commit;
