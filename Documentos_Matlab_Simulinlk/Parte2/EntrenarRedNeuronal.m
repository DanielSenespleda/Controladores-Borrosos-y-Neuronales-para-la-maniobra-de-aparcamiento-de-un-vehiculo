% --- Cargar datos ---
training_data = load("datosEntrenamiento").training_data;

% --- Preparar inputs y outputs ---
inputs = training_data(:,1:12);
outputs = training_data(:,18:19);

% Reemplazar inf por 5 (valor máximo de sensores)
inputs(isinf(inputs)) = 5.0;

% Convertir a double y transponer para red neuronal
inputs = double(inputs');
outputs = double(outputs');

% --- Crear y configurar red ---
net = feedforwardnet([10,3,3]);
net = configure(net, inputs, outputs);

% Evitar normalización automática
net.inputs{1}.processFcns = {};  
net.outputs{2}.processFcns = {};

% --- Entrenar la red ---
[net, tr] = train(net, inputs, outputs);

% --- Generar bloque Simulink ---
gensim(net);

% --- Graficar resultados de validación si existen datos ---
if isempty(tr.valInd)
    disp('No hay datos para validación, no se muestran gráficas.');
else
    val_inputs = inputs(:, tr.valInd);
    val_outputs = outputs(:, tr.valInd);
    pred_outputs = net(val_inputs);

    figure;
    subplot(2,1,1);
    plot(val_outputs(1,:), 'b-', 'LineWidth', 1.5); hold on;
    plot(pred_outputs(1,:), 'r--', 'LineWidth', 1.5);
    title('Salida 1: real vs predicha (validación)');
    legend('Real','Predicha');
    grid on;

    subplot(2,1,2);
    plot(val_outputs(2,:), 'b-', 'LineWidth', 1.5); hold on;
    plot(pred_outputs(2,:), 'r--', 'LineWidth', 1.5);
    title('Salida 2: real vs predicha (validación)');
    legend('Real','Predicha');
    grid on;
end
