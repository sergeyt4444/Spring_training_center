--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: AttrType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."AttrType" AS ENUM (
    'LOGIN',
    'PASSWORD',
    'FIRST_NAME',
    'LAST_NAME',
    'PATRONYMIC',
    'GENDER',
    'DATE_OF_BIRTH',
    'REGISTRATION_DATE',
    'EMAIL',
    'PHONE_NUMBER',
    'USER_DESCRIPTION',
    'TITLE',
    'COURSE_DESCRIPTION',
    'DURATION',
    'DATE_OF_CREATION',
    'ACCESS_TYPE',
    'RATING'
);


ALTER TYPE public."AttrType" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attributes (
    attr_id integer NOT NULL,
    attr_name character varying(30),
    attr_type character varying(30),
    is_multiple boolean,
    is_hidden boolean
);


ALTER TABLE public.attributes OWNER TO postgres;

--
-- Name: attributes_attr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.attributes ALTER COLUMN attr_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.attributes_attr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.id_seq
    START WITH 1000000
    INCREMENT BY -1
    MINVALUE 0
    MAXVALUE 1000001
    CACHE 1;


ALTER TABLE public.id_seq OWNER TO postgres;

--
-- Name: obj_attr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obj_attr (
    obj_attr_id integer NOT NULL,
    obj_id integer,
    attr_id integer,
    value character varying(250)
);


ALTER TABLE public.obj_attr OWNER TO postgres;

--
-- Name: obj_attr_obj_attr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.obj_attr ALTER COLUMN obj_attr_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.obj_attr_obj_attr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: obj_type_attr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obj_type_attr (
    obj_type_attr_id integer NOT NULL,
    obj_type_id integer,
    attr_id integer
);


ALTER TABLE public.obj_type_attr OWNER TO postgres;

--
-- Name: obj_type_attr_obj_type_attr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.obj_type_attr ALTER COLUMN obj_type_attr_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.obj_type_attr_obj_type_attr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: obj_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obj_types (
    obj_types_id integer NOT NULL,
    obj_types_name character varying(30)
);


ALTER TABLE public.obj_types OWNER TO postgres;

--
-- Name: obj_types_obj_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.obj_types ALTER COLUMN obj_types_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.obj_types_obj_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.object (
    obj_id integer NOT NULL,
    obj_type_id integer
);


ALTER TABLE public.object OWNER TO postgres;

--
-- Name: object_obj_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.object ALTER COLUMN obj_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.object_obj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attributes (attr_id, attr_name, attr_type, is_multiple, is_hidden) FROM stdin;
1	course name	text	f	f
2	course description	text	f	f
3	parent ID	number	f	f
4	test attribute	text	f	f
5	creator	text	f	f
7	difficulty	text	f	f
8	language	text	f	f
9	format	text	f	f
6	start date	date	f	f
99	attr11	number	t	t
10	participants required	number	f	f
11	current participants	number	f	f
14	attr name	text	f	f
15	testing attribute creation 3	text	f	f
16	testring	text	f	f
18	new test attr	text	f	f
19	testing scroller	text	f	f
500	username	text	f	f
501	user courses	text	t	f
20	new attribute	text	f	f
21	new attr	text	f	f
22	new testing attr	text	f	f
23	new test attr	text	f	f
24	some attr	text	f	f
25	requirements	text	f	f
26	current participants	text	f	f
27	user courses	text	f	f
28	current participants	text	f	f
29	user courses	text	f	f
30	current participants	text	f	f
31	user courses	text	f	f
32	Random attribute	text	f	f
33	12345	text	f	f
502	courses notified	text	t	f
12	subscribers	text	t	f
34	Address	text	f	f
35	attr1	text	f	f
36	dada	text	f	f
37	adada	text	f	f
38	ddd	text	f	f
39	adadada	text	f	f
40	aaaaaaaaa	text	f	f
41	aadada	text	f	f
503	courses finished	text	t	f
504	courses failed	text	t	f
42	test attr	text	f	f
43	dsaasd	text	f	f
44	asda	text	f	f
45	asd	text	f	f
46	abcfd	text	f	f
47	zxsxdsg	text	f	f
48	attr	text	f	f
49	Link	text	f	f
13	requirements	number	t	f
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1642117905869-1	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.254438	1	EXECUTED	8:d58a6bddb5cfaf5ac03807cdf5fe3093	createTable tableName=object		\N	4.5.0	\N	\N	2117927200
1642117905869-2	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.262855	2	EXECUTED	8:372df27022fc29f8ee80b19c9321e2d9	createTable tableName=attributes		\N	4.5.0	\N	\N	2117927200
1642117905869-3	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.268622	3	EXECUTED	8:e3b42a33b6242f1b86a7f7ad7fc52962	createTable tableName=obj_attr		\N	4.5.0	\N	\N	2117927200
1642117905869-4	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.273855	4	EXECUTED	8:a316a1519d0a16cfc5971f9efd466ce2	createTable tableName=obj_types		\N	4.5.0	\N	\N	2117927200
1642117905869-5	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.278979	5	EXECUTED	8:a6507ed4615da0e9a687ed118a592b7f	createTable tableName=obj_type_attr		\N	4.5.0	\N	\N	2117927200
1642117905869-6	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.284973	6	EXECUTED	8:55b7631c9bebb4e80dda8334e49defb5	addForeignKeyConstraint baseTableName=obj_attr, constraintName=fk_attribute, referencedTableName=attributes		\N	4.5.0	\N	\N	2117927200
1642117905869-7	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.287656	7	EXECUTED	8:59b4c39768e0bb283932ea8cb0151318	addForeignKeyConstraint baseTableName=obj_type_attr, constraintName=fk_attribute, referencedTableName=attributes		\N	4.5.0	\N	\N	2117927200
1642117905869-8	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.290494	8	EXECUTED	8:b35efb953d2fea62706a01bba40b4995	addForeignKeyConstraint baseTableName=obj_type_attr, constraintName=fk_obj_type, referencedTableName=obj_types		\N	4.5.0	\N	\N	2117927200
1642117905869-9	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.293635	9	EXECUTED	8:d31597b7ab008853c450449e5200e550	addForeignKeyConstraint baseTableName=object, constraintName=fk_obj_type, referencedTableName=obj_types		\N	4.5.0	\N	\N	2117927200
1642117905869-10	serge (generated)	classpath:/db/changelog/db.changelog-master.yaml	2022-01-14 02:52:07.296133	10	EXECUTED	8:1e719a760fe15f1fea221b7964e813f8	addForeignKeyConstraint baseTableName=obj_attr, constraintName=fk_object, referencedTableName=object		\N	4.5.0	\N	\N	2117927200
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: obj_attr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obj_attr (obj_attr_id, obj_id, attr_id, value) FROM stdin;
1	2	1	DevOps
4	3	1	Frontend
7	4	1	Backend
10	5	1	UI Design
13	6	1	Machine Learning
16	7	1	Quality Assurance
25	50	12	\N
164	49	6	2022-06-21
425	81	501	
426	81	502	
27	52	12	10;
20	8	2	test
21	8	3	2
2	2	2	DevOps courses description placeholder
5	3	2	Frontend courses description placeholder
8	4	2	Backend courses description placeholder
11	5	2	UI Design courses description placeholder
14	6	2	ML courses description placeholder
17	7	2	QA courses description placeholder
3	2	3	0
6	3	3	0
9	4	3	0
12	5	3	0
15	6	3	0
18	7	3	0
169	49	11	2
160	49	1	Unix systems
185	50	25	basic knowledge of java
176	50	2	Introduction to HTML, CSS, JavaScript. 
183	50	10	25
180	50	7	Easy
161	49	2	Learn to work with unix
79	48	13	\N
81	50	13	\N
82	51	13	\N
31	56	12	10;
83	52	13	\N
440	85	1	Testing sync join
84	53	13	\N
26	51	12	10;
155	9	501	68;49;
43	68	12	9;
85	54	13	\N
32	57	12	10;
449	85	11	1
448	85	10	1
424	81	500	reguser
142	48	11	1
441	85	2	random
44	69	12	
432	83	500	sergeyt4444q@gmail.com
137	48	6	2022-04-21
78	47	13	124;
442	85	3	84
435	84	1	Testing sync
436	84	2	descr
437	84	3	44
438	84	5	administrator
439	84	6	2022/04/04 06:07:43
443	85	5	Иван
434	83	502	85;
445	85	7	Easy
446	85	8	C++
447	85	9	In-person
179	50	6	2022-05-01
65	25	1	Customer support
66	25	2	Customer support description placeholder
67	25	3	0
68	25	5	administrator
69	25	6	2022/02/17 20:23:36
70	26	1	DevOps Subcategory
71	26	2	Description placeholder
72	26	3	2
73	26	5	administrator
74	26	6	2022/02/17 22:47:31
168	49	10	13
444	85	6	2022-04-18
162	49	3	2
163	49	5	Иван
80	49	13	
19	8	1	test category with parent ID
159	11	501	
433	83	501	74;47;85;92;
166	49	8	Python
167	49	9	In-person
165	49	7	Moderate
28	53	12	\N
109	44	2	Description placeholder
110	44	3	43
111	44	5	administrator
112	44	6	2022/02/18 01:38:34
29	54	12	\N
172	47	22	random value
171	49	21	value3
173	47	23	val 321
138	48	7	Hard
139	48	8	Java
140	48	9	In-person
141	48	10	15
30	55	12	\N
174	49	24	1211
175	50	1	Frontend course
177	50	3	3
178	50	5	Иван
103	43	1	Test root category
104	43	2	description placeholder
105	43	3	0
106	43	5	administrator
107	43	6	2022/02/18 01:34:20
108	44	1	Test subcategory
33	58	12	\N
181	50	8	JavaScript
11111	1	99	value1
34	59	12	\N
123	47	1	Course with attributes
124	47	2	Course description
125	47	3	2
126	47	5	Иван
128	47	7	Moderate
129	47	8	Java
130	47	9	Remote
131	47	10	12
182	50	9	Remote
133	48	1	Devops course
134	48	2	Description placeholder
135	48	3	2
136	48	5	Иван
35	60	12	\N
184	50	11	0
147	47	15	something2
148	47	16	testing
150	48	18	val
36	61	12	\N
152	47	19	testing
75	9	500	myuser
76	10	500	administrator
77	11	500	moderator
37	62	12	\N
38	63	12	\N
39	64	12	\N
264	58	1	seven
40	65	12	\N
41	66	12	\N
42	67	12	\N
194	51	3	4
195	51	5	Иван
265	58	2	seven
266	58	3	43
267	58	5	Иван
197	51	7	Moderate
192	51	1	Backend course edited
223	53	11	0
268	58	6	2022-04-07
198	51	8	Python
199	51	9	Remote
202	51	32	12345
269	58	7	Easy
253	56	11	1
200	51	10	98
203	49	33	54321
204	52	1	one
205	52	2	one
206	52	3	43
207	52	5	Иван
208	52	6	2022-04-01
209	52	7	Easy
210	52	8	C++
211	52	9	In-person
212	52	10	10
233	54	11	0
214	53	1	two
215	53	2	two
216	53	3	43
217	53	5	Иван
218	53	6	2022-04-02
219	53	7	Easy
220	53	8	C++
221	53	9	In-person
222	53	10	10
243	55	11	0
224	54	1	three
225	54	2	three
226	54	3	43
227	54	5	Иван
228	54	6	2022-04-03
229	54	7	Easy
230	54	8	C++
231	54	9	In-person
232	54	10	10
201	51	11	1
234	55	1	four
235	55	2	four
236	55	3	43
237	55	5	Иван
238	55	6	2022-04-04
239	55	7	Easy
240	55	8	C++
241	55	9	In-person
242	55	10	10
283	59	11	0
244	56	1	five
245	56	2	five
246	56	3	43
247	56	5	Иван
248	56	6	2022-04-05
249	56	7	Easy
250	56	8	C++
251	56	9	In-person
252	56	10	10
254	57	1	six
255	57	2	six
256	57	3	43
257	57	5	Иван
258	57	6	2022-04-06
259	57	7	Easy
260	57	8	C++
261	57	9	In-person
262	57	10	10
273	58	11	0
271	58	9	In-person
272	58	10	10
274	59	1	eight
275	59	2	eight
276	59	3	43
277	59	5	Иван
278	59	6	2022-04-08
280	59	8	C++
270	58	8	Python
282	59	10	10
293	60	11	0
284	60	1	nine
285	60	2	nine
286	60	3	43
287	60	5	Иван
288	60	6	2022-04-09
289	60	7	Easy
290	60	8	C++
301	61	9	Remote
292	60	10	10
196	51	6	2022-04-29
279	59	7	Hard
295	61	2	ten
296	61	3	43
297	61	5	Иван
298	61	6	2022-04-10
299	61	7	Easy
300	61	8	C++
311	62	9	Remote
302	61	10	10
291	60	9	Remote
304	62	1	eleven
305	62	2	eleven
306	62	3	43
307	62	5	Иван
308	62	6	2022-04-11
309	62	7	Easy
310	62	8	C++
321	63	9	Remote
312	62	10	10
313	62	11	0
314	63	1	twelve
315	63	2	twelve
316	63	3	43
317	63	5	Иван
193	51	2	descr
319	63	7	Easy
320	63	8	C++
331	64	9	Remote
322	63	10	10
323	63	11	0
324	64	1	thirteen
325	64	2	thirteen
326	64	3	43
327	64	5	Иван
328	64	6	2022-04-13
329	64	7	Easy
330	64	8	C++
281	59	9	Remote
332	64	10	10
333	64	11	0
86	55	13	\N
87	56	13	\N
831	126	1	Visuals
263	57	11	1
334	65	1	fourteen
335	65	2	fourteen
336	65	3	43
337	65	5	Иван
338	65	6	2022-04-14
318	63	6	2022-04-12
303	61	11	0
294	61	1	ten1
832	126	2	Courses about visuals
833	126	3	5
339	65	7	Easy
340	65	8	C++
342	65	10	10
343	65	11	0
344	66	1	fifteen
345	66	2	fifteen
346	66	3	43
347	66	5	Иван
348	66	6	2022-04-15
349	66	7	Easy
350	66	8	C++
421	80	500	anotheruser
352	66	10	10
353	66	11	0
354	67	1	sixteen
355	67	2	sixteen
356	67	3	43
357	67	5	Иван
358	67	6	2022-04-16
359	67	7	Easy
360	67	8	C++
422	80	501	
362	67	10	10
363	67	11	0
341	65	9	Remote
351	66	9	Remote
361	67	9	Remote
364	68	1	UI design course
365	68	2	description placeholder
366	68	3	5
367	68	5	Иван
476	90	2	asvdfbcvdsf
369	68	7	Easy
370	68	8	C++
371	68	9	In-person
372	68	10	10
374	69	1	testing descr
375	69	2	testing descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descrtesting descr
376	69	3	25
377	69	5	Иван
378	69	6	2022-02-28
379	69	7	Moderate
380	69	8	C++
381	69	9	In-person
382	69	10	10
838	127	3	5
384	70	1	DevOps SubSubcat
385	70	2	testing categories page
386	70	3	26
387	70	5	administrator
388	70	6	2022/03/07 04:07:39
391	11	502	\N
423	80	502	
392	74	1	Testing notifications
393	74	2	description testing
394	74	3	44
395	74	5	Иван
397	74	7	Easy
398	74	8	C++
399	74	9	In-person
450	86	1	Soft skills
451	86	2	Soft skills courses description placeholder
477	90	3	0
452	86	3	0
453	86	5	administrator
454	86	6	2022/04/18 13:20:22
91	60	13	\N
455	68	34	Room 2
478	90	5	administrator
24	49	12	9;10;
456	87	1	Public speaking
457	87	2	Description placeholder
458	87	3	86
459	87	5	administrator
460	87	6	2022/04/18 13:24:19
389	9	502	
461	88	1	Spring framework
479	90	6	2022/04/18 16:22:14
462	88	2	Introduction to Spring
463	88	3	4
464	88	5	Иван
839	127	5	administrator
466	88	7	Moderate
467	88	8	Java
468	88	9	Remote
469	88	10	10
465	88	6	2022-06-23
470	88	11	0
472	89	500	last
473	89	501	
474	89	502	
132	47	11	1
22	47	12	83;
471	88	12	
834	126	5	administrator
835	126	6	2022/06/12 04:06:01
475	90	1	Demo category
396	74	6	2022-04-27
480	91	1	Demo subcategory
390	10	502	
401	74	11	1
45	74	12	83;
400	74	10	2
481	91	2	12345
482	91	3	90
483	91	5	administrator
484	91	6	2022/04/18 16:22:31
485	92	1	Demo course
486	92	2	descr
487	92	3	91
488	92	5	Иван
489	92	6	2022-04-27
490	92	7	Hard
491	92	8	C++
492	92	9	In-person
495	92	12	83;
836	127	1	Ergonomics
837	127	2	Courses about ergonomics
493	92	10	9
840	127	6	2022/06/12 04:06:20
383	69	11	0
46	85	12	83;
494	92	11	1
368	68	6	2022-06-30
89	58	13	\N
90	59	13	\N
92	61	13	\N
93	62	13	\N
94	63	13	\N
95	64	13	\N
96	65	13	\N
97	66	13	\N
98	67	13	\N
99	68	13	\N
100	69	13	\N
113	74	13	\N
114	85	13	\N
115	88	13	\N
116	92	13	\N
117	124	13	\N
373	68	11	1
23	48	12	10;
88	57	13	
828	125	504	;124
827	125	503	
48	9	504	;
47	9	503	;
127	47	6	2022-07-13
876	132	1	Testing requirements on creation
877	132	2	description
878	132	3	44
879	132	5	Иван
880	132	6	2022-07-27
881	132	7	Easy
882	132	8	C++
883	132	9	In-person
884	132	10	10
886	132	12	
813	124	1	Frontend basics
814	124	2	Basic course
817	124	6	2022-06-29
841	124	34	Room 101
213	52	11	1
815	124	3	3
816	124	5	Иван
818	124	7	Easy
819	124	8	C++
820	124	9	In-person
821	124	10	10
51	11	503	\N
52	11	504	\N
53	80	503	\N
54	80	504	\N
55	81	503	\N
56	81	504	\N
57	83	503	\N
58	83	504	\N
59	89	503	\N
60	89	504	\N
824	125	500	testingusersubs
826	125	502	
822	124	11	2
825	125	501	124;
823	124	12	10;125;
50	10	504	132;51;
924	136	1	demo123
925	136	2	demo
926	136	3	44
927	136	5	Иван
928	136	6	2022-06-30
929	136	7	Easy
930	136	8	C++
931	136	9	In-person
932	136	10	10
935	136	13	56;48;
933	136	11	0
154	10	501	124;49;52;57;51;48;56;
934	136	12	
49	10	503	124;49;52;48;56
887	132	13	57;52;
885	132	11	0
\.


--
-- Data for Name: obj_type_attr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obj_type_attr (obj_type_attr_id, obj_type_id, attr_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
1111	111	99
\.


--
-- Data for Name: obj_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obj_types (obj_types_id, obj_types_name) FROM stdin;
111	objtype111
1	category
2	course
3	user
\.


--
-- Data for Name: object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.object (obj_id, obj_type_id) FROM stdin;
1	111
2	1
3	1
4	1
5	1
6	1
7	1
8	1
124	2
125	3
126	1
127	1
132	2
136	2
0	111
25	1
26	1
43	1
44	1
47	2
48	2
9	3
10	3
11	3
49	2
50	2
51	2
52	2
53	2
54	2
55	2
56	2
57	2
58	2
59	2
60	2
61	2
62	2
63	2
64	2
65	2
66	2
67	2
68	2
69	2
70	1
74	2
80	3
81	3
83	3
84	1
85	2
86	1
87	1
88	2
89	3
90	1
91	1
92	2
\.


--
-- Name: attributes_attr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attributes_attr_id_seq', 49, true);


--
-- Name: id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.id_seq', 1000000, false);


--
-- Name: obj_attr_obj_attr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obj_attr_obj_attr_id_seq', 935, true);


--
-- Name: obj_type_attr_obj_type_attr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obj_type_attr_obj_type_attr_id_seq', 1, false);


--
-- Name: obj_types_obj_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.obj_types_obj_types_id_seq', 1, false);


--
-- Name: object_obj_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.object_obj_id_seq', 136, true);


--
-- Name: attributes attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attributes
    ADD CONSTRAINT attributes_pkey PRIMARY KEY (attr_id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: obj_attr obj_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obj_attr
    ADD CONSTRAINT obj_attr_pkey PRIMARY KEY (obj_attr_id);


--
-- Name: obj_type_attr obj_type_attr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obj_type_attr
    ADD CONSTRAINT obj_type_attr_pkey PRIMARY KEY (obj_type_attr_id);


--
-- Name: obj_types obj_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obj_types
    ADD CONSTRAINT obj_types_pkey PRIMARY KEY (obj_types_id);


--
-- Name: object object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.object
    ADD CONSTRAINT object_pkey PRIMARY KEY (obj_id);


--
-- Name: obj_attr fk_attribute; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obj_attr
    ADD CONSTRAINT fk_attribute FOREIGN KEY (attr_id) REFERENCES public.attributes(attr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: obj_type_attr fk_attribute; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obj_type_attr
    ADD CONSTRAINT fk_attribute FOREIGN KEY (attr_id) REFERENCES public.attributes(attr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: obj_type_attr fk_obj_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obj_type_attr
    ADD CONSTRAINT fk_obj_type FOREIGN KEY (obj_type_id) REFERENCES public.obj_types(obj_types_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: object fk_obj_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.object
    ADD CONSTRAINT fk_obj_type FOREIGN KEY (obj_type_id) REFERENCES public.obj_types(obj_types_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: obj_attr fk_object; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obj_attr
    ADD CONSTRAINT fk_object FOREIGN KEY (obj_id) REFERENCES public.object(obj_id) NOT VALID;


--
-- PostgreSQL database dump complete
--
