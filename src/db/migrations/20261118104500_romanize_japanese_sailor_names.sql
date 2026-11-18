-- Migration: Romanize Japanese-script sailor names using official furigana readings
-- Source: Botchan Cup 2026 official result sheets (furigana column), converted with passport-style Hepburn,
-- Western order (Given Family). The original-script name is preserved in sailor_aliases so imports still match.
-- Skipped on purpose: names whose romanized form already belongs to another sailor (possible duplicates).
BEGIN;

-- 松下 理咲 (マツシタ リサ) -> Risa Matsushita
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('90e79e5f-d8f5-570c-8bd4-6a2f8250fe44'::uuid, '松下 理咲') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Risa Matsushita', updated_at = clock_timestamp() WHERE id = '90e79e5f-d8f5-570c-8bd4-6a2f8250fe44'::uuid AND name = '松下 理咲';

-- 磯谷 柚月 (イソガイ ユズキ) -> Yuzuki Isogai
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('471dd794-a382-5c5d-9645-dcc2fabaa00a'::uuid, '磯谷 柚月') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Yuzuki Isogai', updated_at = clock_timestamp() WHERE id = '471dd794-a382-5c5d-9645-dcc2fabaa00a'::uuid AND name = '磯谷 柚月';

-- 今井 寿 (イマイ ヒサシ) -> Hisashi Imai
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('11a3098c-32f9-5ced-abea-7f3351514044'::uuid, '今井 寿') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Hisashi Imai', updated_at = clock_timestamp() WHERE id = '11a3098c-32f9-5ced-abea-7f3351514044'::uuid AND name = '今井 寿';

-- 鈴木 大陽 (スズキ タイヨウ) -> Taiyo Suzuki
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('a3426655-3a42-5791-b664-796ad8e40a33'::uuid, '鈴木 大陽') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Taiyo Suzuki', updated_at = clock_timestamp() WHERE id = 'a3426655-3a42-5791-b664-796ad8e40a33'::uuid AND name = '鈴木 大陽';

-- 正本 楓 (マサモト カエデ) -> Kaede Masamoto
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c4d0413d-fa88-5eaf-89b6-0bdfafc51438'::uuid, '正本 楓') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Kaede Masamoto', updated_at = clock_timestamp() WHERE id = 'c4d0413d-fa88-5eaf-89b6-0bdfafc51438'::uuid AND name = '正本 楓';

-- 坂田 遼太郎 (サカタ リョウタロウ) -> Ryotaro Sakata
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('aad76e94-1563-5bce-bf2a-810270dbabbd'::uuid, '坂田 遼太郎') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Ryotaro Sakata', updated_at = clock_timestamp() WHERE id = 'aad76e94-1563-5bce-bf2a-810270dbabbd'::uuid AND name = '坂田 遼太郎';

-- 合田 香佑 (ゴウダ コウスケ) -> Kosuke Goda
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('920b47a8-3872-5bbb-854e-e25700d6b136'::uuid, '合田 香佑') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Kosuke Goda', updated_at = clock_timestamp() WHERE id = '920b47a8-3872-5bbb-854e-e25700d6b136'::uuid AND name = '合田 香佑';

-- 磯谷 柚衣 (イソガイ ユイ) -> Yui Isogai
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('93a422bb-59a5-5d26-969b-9d8251862e28'::uuid, '磯谷 柚衣') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Yui Isogai', updated_at = clock_timestamp() WHERE id = '93a422bb-59a5-5d26-969b-9d8251862e28'::uuid AND name = '磯谷 柚衣';

-- 槇場 康介 (マキバ コウスケ) -> Kosuke Makiba
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('6c56a52d-1475-553a-808b-6d68eecf1fd0'::uuid, '槇場 康介') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Kosuke Makiba', updated_at = clock_timestamp() WHERE id = '6c56a52d-1475-553a-808b-6d68eecf1fd0'::uuid AND name = '槇場 康介';

-- 中村 一心 (ナカムラ イッシン) -> Isshin Nakamura
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('61b9ec5f-f615-5065-b244-a24c2077ee18'::uuid, '中村 一心') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Isshin Nakamura', updated_at = clock_timestamp() WHERE id = '61b9ec5f-f615-5065-b244-a24c2077ee18'::uuid AND name = '中村 一心';

-- 北山 新 (キタヤマ アラタ) -> Arata Kitayama
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('68cd92c4-0159-53ab-aeb9-ba6e7c0e2b0a'::uuid, '北山 新') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Arata Kitayama', updated_at = clock_timestamp() WHERE id = '68cd92c4-0159-53ab-aeb9-ba6e7c0e2b0a'::uuid AND name = '北山 新';

-- 甲田 伊織 (コウダ イオリ) -> Iori Koda
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('d7c13c23-63fd-5188-9ce1-8b76b1fbfa85'::uuid, '甲田 伊織') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Iori Koda', updated_at = clock_timestamp() WHERE id = 'd7c13c23-63fd-5188-9ce1-8b76b1fbfa85'::uuid AND name = '甲田 伊織';

-- 岩永 航祐 (イワナガ コウスケ) -> Kosuke Iwanaga
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('790a4a6a-663c-5406-b67d-a67c213695ed'::uuid, '岩永 航祐') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Kosuke Iwanaga', updated_at = clock_timestamp() WHERE id = '790a4a6a-663c-5406-b67d-a67c213695ed'::uuid AND name = '岩永 航祐';

-- 石井 陽大 (イシイ ヨウタ) -> Yota Ishii
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('b58891bb-36e8-5646-8ab6-1340ed6613b2'::uuid, '石井 陽大') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Yota Ishii', updated_at = clock_timestamp() WHERE id = 'b58891bb-36e8-5646-8ab6-1340ed6613b2'::uuid AND name = '石井 陽大';

-- 上田 瑚子 (ウエダ ココ) -> Koko Ueda
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('361539d8-8ccd-5a35-a335-fe557b078f97'::uuid, '上田 瑚子') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Koko Ueda', updated_at = clock_timestamp() WHERE id = '361539d8-8ccd-5a35-a335-fe557b078f97'::uuid AND name = '上田 瑚子';

-- 田甫 大悟 (タホ ダイゴ) -> Daigo Taho
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('f1ef779f-5dec-5213-9779-a1abf62b7023'::uuid, '田甫 大悟') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Daigo Taho', updated_at = clock_timestamp() WHERE id = 'f1ef779f-5dec-5213-9779-a1abf62b7023'::uuid AND name = '田甫 大悟';

-- 梶原 研三 (カジワラ ケンゾウ) -> Kenzo Kajiwara
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('629c1cb0-5d71-5bf6-8eca-76b831c1057b'::uuid, '梶原 研三') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Kenzo Kajiwara', updated_at = clock_timestamp() WHERE id = '629c1cb0-5d71-5bf6-8eca-76b831c1057b'::uuid AND name = '梶原 研三';

-- 坂口 真規 (サカグチ マサキ) -> Masaki Sakaguchi
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5fe0ec7e-b21d-5f52-a42b-8bb6bc00b374'::uuid, '坂口 真規') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Masaki Sakaguchi', updated_at = clock_timestamp() WHERE id = '5fe0ec7e-b21d-5f52-a42b-8bb6bc00b374'::uuid AND name = '坂口 真規';

-- 坂本 糸 (サカモト イト) -> Ito Sakamoto
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ba4ad867-3360-5435-aa27-3a40a2ac77cc'::uuid, '坂本 糸') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Ito Sakamoto', updated_at = clock_timestamp() WHERE id = 'ba4ad867-3360-5435-aa27-3a40a2ac77cc'::uuid AND name = '坂本 糸';

-- 春貝地 陸人 (ハルガイチ リクト) -> Rikuto Harugaichi
INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('e485b775-aaa6-52f1-a9e9-b30c433f5cc0'::uuid, '春貝地 陸人') ON CONFLICT (alias_name) DO NOTHING;
UPDATE public.sailors SET name = 'Rikuto Harugaichi', updated_at = clock_timestamp() WHERE id = 'e485b775-aaa6-52f1-a9e9-b30c433f5cc0'::uuid AND name = '春貝地 陸人';

COMMIT;
