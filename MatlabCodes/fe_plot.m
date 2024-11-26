figure;
hold on; grid on;
plot(0:0.1:(0.1*(271-1)), form_err_15, "green", "LineWidth", 1.5);
plot(0:0.1:(0.1*(466-1)), form_err_10, "blue", "LineWidth", 2);
plot(0:0.1:(0.1*(315-1)), form_err_6, "red", "LineWidth", 3);
%title("\textbf{Formation error comparison between different measurement noise simulations [m]}", "Interpreter","latex","FontSize", 14);
set(gca, "FontSize", 20);
xlim([0 20]);
xlabel("Time [s]", "Interpreter","latex","FontSize", 40);
ylabel("\(|fe_{L,F}|\) [m]", "Interpreter","latex","FontSize", 40);
legend("15cm", "10cm", "6cm", "Interpreter","latex","FontSize", 25);

%%

figure;
hold on; grid on;
plot(0:0.1:(0.1*(179-1)), form_err_2, "green", "LineWidth", 1.5);
plot(0:0.1:(0.1*(150-1)), form_err_1, "blue", "LineWidth", 2);
plot(0:0.1:(0.1*(151-1)), form_err_05, "red", "LineWidth", 3);
%title("\textbf{Formation error comparison between different measurement noise simulations [m]}", "Interpreter","latex","FontSize", 14);
set(gca, "FontSize", 20);
xlim([0 14]);
xlabel("Time [s]", "Interpreter","latex","FontSize", 40);
ylabel("\(|fe_{L,F}|\) [m]", "Interpreter","latex","FontSize", 40);
legend("2cm", "1cm", "5mm", "Interpreter","latex","FontSize", 25);

%%