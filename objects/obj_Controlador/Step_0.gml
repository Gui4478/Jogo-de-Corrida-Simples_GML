
#region SISTEMA DE DIA E NOITE (!)
//periodicamente troca a iluminação/cores do ambiente, é sinalizado para o jogador por um sol/lua que passa pela tela
#endregion


#region OPERAÇÕES
//algoritmo de terreno
{/*}	RASCUNHO
	Pode ser:
	1. um algoritmo que decide o começo, meio e final do
	obstáculo de terreno e que pode criar outro um obstáculo normal ou
	de terreno em cima dele (algoritmo recursivo limitado, mais ou menos
	3 vezes)
	2. elevar ou abaixar o nivel o terreno em uma vez.	
*/}

if(obstaculo_intervalo_t < 1) gerar_obstaculo();
{/*}	RASCUNHO
	Algoritmo que escolhe aleatoriamente o obstáculo a ser gerádo,
	levar em consideração o tempo de jogo para gerar obstáculos
	mais difíceis.
		
	PROTÓTIPO:
	se passou_de_algum_tempo_específico, então adiciona strings (nome do obstáculo) no array_de_strings
		
	se obstaculo_intervalo_t < 1
		cria obstáculo no nivel do chão atual e fora da tela
		var nome_obstáculo = choose(array_de_strings)
		switch(nome_obstáculo)
			configura obstáculo de acordo com a opção selecionada
		define delay até próximo obstáculo (intervalo fica levemente menor conforme a velocidade aumenta)
*/}

#endregion


#region MOVIMENTAÇÃO GLOBAL (*)
{/*} Problema .1 (Baixa Prioridade)
	PROBLEMA: Provável que a colisão não seja visualmente perceptivel ou pareça
	errada em altas velocidades pois, como os obstáculos se movem exatamente
	vários pixels por frame, quando o obj_Player realizar o estado "morto" no
	frame seguinte da colisão o obstáculo já pode estar muito distante dele,
	fazendo parecer que a colisão foi feita de forma errada.
	SOLUÇÕES:
	1. Ignorar caso não seja tão grave
	2. Reestruturar o código para ele instantaneamente parar o movimneto global
	no exato momento da colisão
	3. Causar um evento específico (animação do player caindo e se arrastando
	no chão) quando ocorrer a colisão (em vez de apenas pausar "na hora"),
	assim o player apenas sabe que houve uma colisão em vez de ver o momento 
	levemente atrasado.
*/}
if global.GameStatus == "Jogando"
{	
	var velh = global.velhGlobal + other.velh_acumulador;
	repeat(velh)
	{
		with obj_Movel
		{
			#region INTERAÇÃO COM RAMPAS (!)
			#endregion
			
			x -= 1;
			if self.velh != 0
			{
				x -= self.velh;
				self.velh -= sign(self.velh)
			}
		
			if(place_meeting(x,y, obj_Player)) obj_Player.estado = "morto";
		}
		if(obj_Player.estado == "morto") break;
	}
		
	//	Reaproveitamento da parte fracionada
	var velh = global.velhGlobal;
	if(floor(velh) < floor(velh + velh_acumulador)) velh_acumulador -= 1 - frac(velh);
	else if(frac(velh) != 0) velh_acumulador += frac(velh);
	
	{/*} ...
	with obj_Movel //NOTA: Devo criar um objeto mais abstráto para tratar todos os que se movem? Provalvel
	{
		#region Movimentação & Colisão
		var velh = global.velhGlobal + other.velh_acumulador;
		repeat(velh + self.velh)
		{
			#region INTERAÇÃO COM RAMPAS (!)
			/*if object_get_name(object_index) == "obj_Solido_movel" //tentar ver se "if object_get_name(id)" funciona
			{
				//CÁDIGOS VINDOS DO PLAYER, NÃO ADAPTADOS PRO OBJ_SOLIDO_MOVEL
				//faz player subir rampa
				if place_meeting(x+_velh, y, obj_Solido) and !place_meeting(x+_velh, y-1, obj_Solido)
				{
					y--;
				}
				//faz player descer rampa
				if !place_meeting(x+_velh, y, obj_Solido) and !place_meeting(x+_velh, y+1, obj_Solido) and !place_meeting(x+_velh, y+2, obj_Solido)
				{
					y++;
				}
			}//* /
			#endregion
			
			x -= 1;
			if(place_meeting(x,y, obj_Player)) obj_Player.estado = "morto";
			
			if(object_get_name(object_index) == "obj_Controlador") and (abs(x) == room_width) x = 0; 
		}
		#endregion
	}
	
	//	Reaproveitamento da parte fracionada
	var velh = global.velhGlobal;
	if(floor(velh) < floor(velh + velh_acumulador)) velh_acumulador -= 1 - frac(velh);
	else if(frac(velh) != 0) velh_acumulador += frac(velh);
	*/}
}
#endregion
