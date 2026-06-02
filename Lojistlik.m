

musteriSayisi = 30;
aracSayisi = 3;

depo = [50 50];

yakitTuketimi = 30; 
yakitFiyati = 52;   



musteriler = rand(musteriSayisi,2) * 100;




musteriAraci = zeros(musteriSayisi,1);

for i = 1:musteriSayisi

    musteriAraci(i) = mod(i-1,aracSayisi) + 1;

end





figure;
hold on;
grid on;

scatter(musteriler(:,1),musteriler(:,2),70,'filled');
scatter(depo(1),depo(2),250,'filled');

title('Lojistik Filo Yonetim Sistemi');





toplamFiloMesafesi = 0;
toplamFiloYakiti = 0;
toplamFiloMaliyeti = 0;





for arac = 1:aracSayisi

    aracMusterileri = [];

    


    for i = 1:musteriSayisi

        if musteriAraci(i) == arac

            aracMusterileri(end+1,:) = musteriler(i,:);

        end

    end

    mevcutKonum = depo;

    rota = depo;

    gidilenMesafe = 0;

    ziyaretEdilmeyenler = aracMusterileri;

    while ~isempty(ziyaretEdilmeyenler)

        mesafeler = zeros(size(ziyaretEdilmeyenler,1),1);

        



        for j = 1:size(ziyaretEdilmeyenler,1)

            x1 = mevcutKonum(1);
            y1 = mevcutKonum(2);

            x2 = ziyaretEdilmeyenler(j,1);
            y2 = ziyaretEdilmeyenler(j,2);

            mesafeler(j) = sqrt((x2-x1)^2 + (y2-y1)^2);

        end

        [enKisaMesafe,index] = min(mesafeler);

        sonrakiNokta = ziyaretEdilmeyenler(index,:);

        gidilenMesafe = gidilenMesafe + enKisaMesafe;

        rota(end+1,:) = sonrakiNokta;

        mevcutKonum = sonrakiNokta;

        ziyaretEdilmeyenler(index,:) = [];

    end

   


    dx = mevcutKonum(1) - depo(1);
    dy = mevcutKonum(2) - depo(2);

    donusMesafesi = sqrt(dx^2 + dy^2);

    gidilenMesafe = gidilenMesafe + donusMesafesi;

    rota(end+1,:) = depo;

  


    harcananYakit = gidilenMesafe * yakitTuketimi / 100;

    yakitMaliyeti = harcananYakit * yakitFiyati;

    

    toplamFiloMesafesi = toplamFiloMesafesi + gidilenMesafe;
    toplamFiloYakiti = toplamFiloYakiti + harcananYakit;
    toplamFiloMaliyeti = toplamFiloMaliyeti + yakitMaliyeti;

   


    plot(rota(:,1),rota(:,2),'LineWidth',2);

   


    fprintf('\n');
    fprintf('=== ARAC %d ===\n',arac);

    fprintf('Musteri Sayisi : %d\n',size(aracMusterileri,1));
    fprintf('Mesafe         : %.2f km\n',gidilenMesafe);
    fprintf('Yakit          : %.2f L\n',harcananYakit);
    fprintf('Maliyet        : %.2f TL\n',yakitMaliyeti);

end

legend('Musteriler','Depo');





fprintf('\n');
fprintf('=============================\n');
fprintf('GENEL FILO RAPORU\n');
fprintf('=============================\n');

fprintf('Toplam Arac    : %d\n',aracSayisi);
fprintf('Toplam Musteri : %d\n',musteriSayisi);
fprintf('Toplam Mesafe  : %.2f km\n',toplamFiloMesafesi);
fprintf('Toplam Yakit   : %.2f L\n',toplamFiloYakiti);
fprintf('Toplam Maliyet : %.2f TL\n',toplamFiloMaliyeti);