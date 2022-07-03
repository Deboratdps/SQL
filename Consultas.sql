SELECT * FROM fornecedor;

SELECT nome FROM fornecedor;

SELECT oc.id, oc.data, f.nome 
FROM fornecedor as f, ordem_compra as oc;

SELECT oc.id, oc.data, f.nome 
FROM fornecedor as f, ordem_compra as oc
WHERE oc.idFornecedor = f.id;

SELECT oc.id, oc.data, f.nome 
FROM fornecedor as f, ordem_compra as oc
WHERE oc.idFornecedor = f.id
ORDER BY f.ie;

SELECT oc.id, oc.data, f.nome 
FROM fornecedor as f, ordem_compra as oc
WHERE oc.idFornecedor = f.id
ORDER BY f.ie DESC;

SELECT ioc.idOrdemCompra, ioc.idMaterial, m.nome
FROM item_ordem_compra as ioc, material as m
WHERE ioc.idMaterial = m.id;

SELECT ioc.idOrdemCompra, ioc.idMaterial, m.nome
FROM item_ordem_compra as ioc, material as m
WHERE ioc.idMaterial = m.id
ORDER BY ioc.idOrdemCompra;

/*1. Exiba os dados da compra (item_ordem_compra) de todos os materiais cujo quantidade seja maior que 10.*/
SELECT *
FROM item_ordem_compra
WHERE quantidade > 10;
-- **********************************************************************************
/*2. Exiba os dados da compra (item_ordem_compra) de todos os materiais cujo valor seja menor que 50.*/
SELECT *
FROM item_ordem_compra
WHERE valor < 50;

SELECT *
FROM item_ordem_compra
WHERE quantidade > 10 AND valor < 50;
-- **********************************************************************************
/*3. Exibir os dados da compra de todos os materiais cuja quantidade seja maior que 100 e o valor menor que 50, contendo o nome do material e o nome do fornecedor*/
SELECT ioc.*, m.nome as material, f.nome as fornecedor
FROM item_ordem_compra as ioc, material as m, fornecedor as f, ordem_compra as oc
WHERE ioc.quantidade > 100 AND ioc.valor < 50 
	AND ioc.idMaterial = m.id 
	AND ioc.idOrdemCompra = oc.id
	AND oc.idFornecedor = f.id
ORDER BY ioc.idOrdemCompra;
-- **********************************************************************************
SELECT *, quantidade*valor as subTotal
FROM item_ordem_compra
-- **********************************************************************************
/*4. Exiba o subtotal de cada material vendido, o nome do material e o nome do fornecedor*/
SELECT ioc.*, m.nome as material, f.nome as fornecedor, ioc.quantidade*ioc.valor as subTotal
FROM item_ordem_compra as ioc, material as m, fornecedor as f, ordem_compra as oc
WHERE ioc.idMaterial = m.id 
	AND ioc.idOrdemCompra = oc.id
	AND oc.idFornecedor = f.id
ORDER BY ioc.idOrdemCompra;
-- **********************************************************************************
SELECT idOrdemCompra, SUM(quantidade*valor) as totalCompra
FROM item_ordem_compra
GROUP BY idOrdemCompra;
-- **********************************************************************************
SELECT idOrdemCompra, SUM(valor*quantidade) as totalCompra
FROM item_ordem_compra
GROUP BY idOrdemCompra
HAVING totalCompra > 5000;
-- **********************************************************************************
/*5. O nome do fornecedor da ordem de compra, a ordem de compra, o total pago pela ordem de compra*/
SELECT f.nome, ioc.idOrdemCompra, SUM(ioc.quantidade*ioc.valor) as Total
FROM item_ordem_compra as ioc, fornecedor as f, ordem_compra as oc
WHERE ioc.idOrdemCompra = oc.id
	AND oc.idFornecedor = f.id
GROUP BY ioc.idOrdemCompra;
-- **********************************************************************************
/*6. O nome do fornecedor da ordem de compra, a data, o total pago pela ordem de compra, num determinado intervalo*/
SELECT f.nome, oc.data, SUM(ioc.quantidade*ioc.valor) as Total
FROM item_ordem_compra as ioc, fornecedor as f, ordem_compra as oc
WHERE ioc.idOrdemCompra = oc.id
	AND oc.idFornecedor = f.id
	AND oc.data BETWEEN '2022-05-15' AND '2022-05-20'
GROUP BY ioc.idOrdemCompra;
-- 01/07*****************************************************************************
/*1. Listar o nome de cada material e o valor medio desse material*/
SELECT m.nome as material, AVG(ioc.valor) as Media
FROM item_ordem_compra as ioc, material as m 
WHERE ioc.idMaterial = m.id 
GROUP BY m.nome;
-- **********************************************************************************
/*2. Listar o nome de cada material e o valor medio desse material entre os dias 10 e 13 de maio*/
SELECT f.nome, oc.data, AVG(ioc.valor) as Media
FROM item_ordem_compra as ioc, fornecedor as f, ordem_compra as oc
WHERE ioc.idOrdemCompra = oc.id
	AND oc.idFornecedor = f.id
	AND oc.data BETWEEN '2022-05-10' AND '2022-05-13'
GROUP BY ioc.idOrdemCompra;
-- **********************************************************************************
/*3. Qual é o produto que mais aparece nas compras*/
SELECT COUNT(ioc.idMaterial) as contagem, m.nome as material
FROM item_ordem_compra as ioc, material as m 
WHERE ioc.idMaterial = m.id 
GROUP BY ioc.idMaterial;
-- **********************************************************************************
UPDATE material SET nome='Prego'
WHERE id = 2;
-- **********************************************************************************
DELETE FROM item_ordem_compra
WHERE idOrdemCompra = 5 
  AND idMaterial = 11;