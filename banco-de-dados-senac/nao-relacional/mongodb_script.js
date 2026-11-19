// ============================================================
// BANCO NÃO RELACIONAL (MongoDB) - Exercício
//   1) Criar 2 Databases
//   2) Criar 5 collections em cada Database
//   3) Inserir pelo menos 5 documentos em cada collection
//
// Como executar (MongoDB Shell):
//   mongosh --file mongodb_script.js
// ou, dentro do mongosh:  load("mongodb_script.js")
// ============================================================

// ============================================================
// DATABASE 1: loja_virtual
// Collections: clientes, produtos, pedidos, categorias, avaliacoes
// ============================================================
db = db.getSiblingDB("loja_virtual");
db.dropDatabase();                       // recria do zero para poder reexecutar
db = db.getSiblingDB("loja_virtual");

db.createCollection("clientes");
db.createCollection("produtos");
db.createCollection("pedidos");
db.createCollection("categorias");
db.createCollection("avaliacoes");

db.clientes.insertMany([
  { _id: 1, nome: "Ana Souza",     email: "ana@email.com",     cidade: "Sao Paulo",      estado: "SP", ativo: true },
  { _id: 2, nome: "Bruno Lima",    email: "bruno@email.com",   cidade: "Rio de Janeiro", estado: "RJ", ativo: true },
  { _id: 3, nome: "Carla Dias",    email: "carla@email.com",   cidade: "Belo Horizonte", estado: "MG", ativo: false },
  { _id: 4, nome: "Daniel Rocha",  email: "daniel@email.com",  cidade: "Maceio",         estado: "AL", ativo: true },
  { _id: 5, nome: "Eduarda Melo",  email: "eduarda@email.com", cidade: "Santos",         estado: "SP", ativo: true }
]);

db.categorias.insertMany([
  { _id: 1, nome: "Informatica", descricao: "Computadores e acessorios" },
  { _id: 2, nome: "Celulares",   descricao: "Smartphones e acessorios" },
  { _id: 3, nome: "Moveis",      descricao: "Moveis para casa e escritorio" },
  { _id: 4, nome: "Games",       descricao: "Consoles e jogos" },
  { _id: 5, nome: "Audio",       descricao: "Fones e caixas de som" }
]);

db.produtos.insertMany([
  { _id: 1, nome: "Notebook",      categoria: "Informatica", preco: 3500.00, estoque: 15, tags: ["trabalho", "estudo"] },
  { _id: 2, nome: "Smartphone",    categoria: "Celulares",   preco: 2800.00, estoque: 30, tags: ["android", "5g"] },
  { _id: 3, nome: "Cadeira Gamer", categoria: "Moveis",      preco: 1250.00, estoque: 8,  tags: ["ergonomica"] },
  { _id: 4, nome: "Console",       categoria: "Games",       preco: 4200.00, estoque: 5,  tags: ["jogos", "4k"] },
  { _id: 5, nome: "Fone Bluetooth",categoria: "Audio",       preco: 149.90,  estoque: 100,tags: ["sem fio"] }
]);

db.pedidos.insertMany([
  { _id: 1, id_cliente: 1, data: new Date("2026-03-03"), status: "Entregue",  itens: [{ produto: "Notebook", qtd: 1 }],                           total: 3500.00 },
  { _id: 2, id_cliente: 2, data: new Date("2026-03-10"), status: "Enviado",   itens: [{ produto: "Smartphone", qtd: 1 }, { produto: "Fone Bluetooth", qtd: 2 }], total: 3099.80 },
  { _id: 3, id_cliente: 3, data: new Date("2026-04-01"), status: "Cancelado", itens: [{ produto: "Cadeira Gamer", qtd: 1 }],                       total: 1250.00 },
  { _id: 4, id_cliente: 4, data: new Date("2026-04-15"), status: "Pago",      itens: [{ produto: "Console", qtd: 1 }],                             total: 4200.00 },
  { _id: 5, id_cliente: 5, data: new Date("2026-05-02"), status: "Entregue",  itens: [{ produto: "Fone Bluetooth", qtd: 1 }],                      total: 149.90 }
]);

db.avaliacoes.insertMany([
  { _id: 1, id_cliente: 1, produto: "Notebook",       nota: 5, comentario: "Excelente desempenho" },
  { _id: 2, id_cliente: 2, produto: "Smartphone",     nota: 4, comentario: "Bom, bateria poderia ser melhor" },
  { _id: 3, id_cliente: 4, produto: "Console",        nota: 5, comentario: "Grafico impressionante" },
  { _id: 4, id_cliente: 5, produto: "Fone Bluetooth", nota: 3, comentario: "Som ok, conexao falha as vezes" },
  { _id: 5, id_cliente: 3, produto: "Cadeira Gamer",  nota: 2, comentario: "Chegou com defeito" }
]);

// ---- Consultas de teste (loja_virtual) ----
print("--- clientes ---");               printjson(db.clientes.find().toArray());
print("--- clientes de SP ---");         printjson(db.clientes.find({ estado: "SP" }).toArray());
print("--- produtos > R$ 1000 ---");     printjson(db.produtos.find({ preco: { $gt: 1000 } }, { nome: 1, preco: 1 }).toArray());
print("--- pedidos entregues ---");      printjson(db.pedidos.find({ status: "Entregue" }).toArray());
print("--- media de notas por produto ---");
printjson(db.avaliacoes.aggregate([{ $group: { _id: "$produto", media: { $avg: "$nota" } } }]).toArray());
print("--- total de documentos ---");
["clientes", "produtos", "pedidos", "categorias", "avaliacoes"].forEach(c =>
  print(c + ": " + db.getCollection(c).countDocuments()));

// ============================================================
// DATABASE 2: escola_mongo
// Collections: alunos, professores, cursos, disciplinas, matriculas
// ============================================================
db = db.getSiblingDB("escola_mongo");
db.dropDatabase();
db = db.getSiblingDB("escola_mongo");

db.createCollection("alunos");
db.createCollection("professores");
db.createCollection("cursos");
db.createCollection("disciplinas");
db.createCollection("matriculas");

db.alunos.insertMany([
  { _id: 1, nome: "Gabriel Torres",  data_nascimento: new Date("2004-02-14"), email: "gabriel@aluno.com", cidade: "Sao Paulo" },
  { _id: 2, nome: "Helena Martins",  data_nascimento: new Date("2003-07-21"), email: "helena@aluno.com",  cidade: "Santos" },
  { _id: 3, nome: "Igor Fernandes",  data_nascimento: new Date("2005-11-03"), email: "igor@aluno.com",    cidade: "Guarulhos" },
  { _id: 4, nome: "Julia Almeida",   data_nascimento: new Date("2002-09-30"), email: "julia@aluno.com",   cidade: "Osasco" },
  { _id: 5, nome: "Lucas Carvalho",  data_nascimento: new Date("2004-12-12"), email: "lucas@aluno.com",   cidade: "Sao Paulo" }
]);

db.professores.insertMany([
  { _id: 1, nome: "Alberto Silva",   area: "Banco de Dados",  titulacao: "Mestre" },
  { _id: 2, nome: "Cristina Santos", area: "Programacao",     titulacao: "Doutora" },
  { _id: 3, nome: "Zagalo Oliveira", area: "Redes",           titulacao: "Especialista" },
  { _id: 4, nome: "Fernanda Lopes",  area: "Engenharia de Software", titulacao: "Mestre" },
  { _id: 5, nome: "Jose Luiz",       area: "Matematica",      titulacao: "Doutor" }
]);

db.cursos.insertMany([
  { _id: 1, nome: "Analise e Desenvolvimento de Sistemas", duracao_semestres: 5, turno: "Noite" },
  { _id: 2, nome: "Ciencia de Dados",                      duracao_semestres: 4, turno: "Manha" },
  { _id: 3, nome: "Redes de Computadores",                 duracao_semestres: 4, turno: "Noite" },
  { _id: 4, nome: "Seguranca da Informacao",               duracao_semestres: 4, turno: "Tarde" },
  { _id: 5, nome: "Engenharia de Software",                duracao_semestres: 8, turno: "Noite" }
]);

db.disciplinas.insertMany([
  { _id: 1, nome: "Banco de Dados",      carga_horaria: 80, id_professor: 1 },
  { _id: 2, nome: "Programacao Web",     carga_horaria: 80, id_professor: 2 },
  { _id: 3, nome: "Redes",               carga_horaria: 60, id_professor: 3 },
  { _id: 4, nome: "Engenharia de Requisitos", carga_horaria: 60, id_professor: 4 },
  { _id: 5, nome: "Matematica Discreta", carga_horaria: 60, id_professor: 5 }
]);

db.matriculas.insertMany([
  { _id: 1, id_aluno: 1, id_curso: 1, ano: 2026, semestre: 2, situacao: "Ativa" },
  { _id: 2, id_aluno: 2, id_curso: 2, ano: 2026, semestre: 2, situacao: "Ativa" },
  { _id: 3, id_aluno: 3, id_curso: 3, ano: 2026, semestre: 1, situacao: "Trancada" },
  { _id: 4, id_aluno: 4, id_curso: 4, ano: 2025, semestre: 2, situacao: "Concluida" },
  { _id: 5, id_aluno: 5, id_curso: 1, ano: 2026, semestre: 2, situacao: "Ativa" }
]);

// ---- Consultas de teste (escola_mongo) ----
print("--- alunos ---");                  printjson(db.alunos.find().toArray());
print("--- matriculas ativas ---");       printjson(db.matriculas.find({ situacao: "Ativa" }).toArray());
print("--- disciplinas >= 80h ---");      printjson(db.disciplinas.find({ carga_horaria: { $gte: 80 } }).toArray());
print("--- alunos por curso ---");
printjson(db.matriculas.aggregate([{ $group: { _id: "$id_curso", total: { $sum: 1 } } }]).toArray());
print("--- join (lookup) disciplinas + professores ---");
printjson(db.disciplinas.aggregate([
  { $lookup: { from: "professores", localField: "id_professor", foreignField: "_id", as: "professor" } },
  { $project: { nome: 1, "professor.nome": 1 } }
]).toArray());
print("--- total de documentos ---");
["alunos", "professores", "cursos", "disciplinas", "matriculas"].forEach(c =>
  print(c + ": " + db.getCollection(c).countDocuments()));

print("--- databases criados ---");
printjson(db.getMongo().getDBNames());
