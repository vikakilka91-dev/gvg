
-- ==========================================
-- Домашняя работа: уроки 3–4
-- Нормализация базы данных до 3НФ
-- ==========================================

-- 1. Таблица учебных групп
CREATE TABLE Groups (
    group_id VARCHAR(10) PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Таблица студентов
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    group_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (group_id) REFERENCES Groups(group_id)
);

-- 3. Таблица преподавателей
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL
);

-- 4. Таблица предметов
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL UNIQUE,
    teacher_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- 5. Таблица оценок студентов
CREATE TABLE StudentGrades (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    exam_date DATE NOT NULL,
    grade INT NOT NULL CHECK (grade BETWEEN 2 AND 5),

    PRIMARY KEY (student_id, subject_id, exam_date),

    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- ==========================================
-- Заполнение таблиц данными
-- ==========================================

INSERT INTO Groups (group_id, group_name) VALUES
('G-1', 'Группа А'),
('G-2', 'Группа Б');

INSERT INTO Teachers (teacher_id, teacher_name) VALUES
(5, 'Петрова М.'),
(7, 'Смирнов А.'),
(8, 'Козлова Е.');

INSERT INTO Students (student_id, student_name, group_id) VALUES
(1, 'Петров П.', 'G-1'),
(2, 'Иванов И.', 'G-1'),
(3, 'Сидоров С.', 'G-2'),
(4, 'Петров П.', 'G-1'),
(5, 'Кузнецов К.', 'G-2');

INSERT INTO Subjects (subject_id, subject_name, teacher_id) VALUES
(1, 'Математика', 5),
(2, 'Физика', 7),
(3, 'Информатика', 8);

INSERT INTO StudentGrades
    (student_id, subject_id, exam_date, grade)
VALUES
(1, 1, '2026-01-15', 4),
(2, 2, '2026-01-20', 3),
(3, 1, '2026-01-18', 5),
(4, 3, '2026-01-25', 5),
(5, 2, '2026-01-22', 4);

-- ==========================================
-- Проверка данных: вывод оценок с именами
-- ==========================================

SELECT
    s.student_id,
    s.student_name,
    g.group_name,
    t.teacher_name,
    sub.subject_name,
    sg.exam_date,
    sg.grade
FROM StudentGrades sg
JOIN Students s ON sg.student_id = s.student_id
JOIN Groups g ON s.group_id = g.group_id
JOIN Subjects sub ON sg.subject_id = sub.subject_id
JOIN Teachers t ON sub.teacher_id = t.teacher_id
ORDER BY sg.exam_date;
