warn('plsss optimizeeeee')
if not game:IsLoaded() then
	game.Loaded:Wait()
end

getgenv().lilix = getgenv().lilix or nil
getgenv().relix = getgenv().relix or nil

getgenv().key = nil
getgenv().luarmor_api = nil
getgenv().key_expire = nil
getgenv().key_note = nil
getgenv().key_executions = nil

if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...) return ... end
	LPH_NO_VIRTUALIZE = function(f) return f end
	LPH_NO_UPVALUES = function(...) return ... end
	LPH_CRASH = function(...) return ... end
else
	print = function() end
	warn = function() end
end

if (identifyexecutor() == "Wave") then
	getgenv().gethui = function()
		return game:GetService("CoreGui");
	end;
end;

local Library = getgenv().Library or {}

if type(Library) == "table" and next(Library) then
	if type(Library.Unload) == "function" then
		pcall(Library.Unload, Library)
	end

	for key in pairs(Library) do
		Library[key] = nil
	end
end

getgenv().Library = Library

local GameId = tostring(game.GameId)
local PlaceId = tostring(game.PlaceId)

local Folder_Configs = {
	Directory = "solixhub",
	Assets = "solixhub/Assets",
	Configurations = "solixhub/Configurations",
	Datas = "solixhub/Datas",
	Images = "solixhub/Images",
	Themes = "solixhub/Themes"
}

local function GetFolders()
	return Library.Folders or Folder_Configs
end

local function GetAutoloadPath()
	return Folder_Configs.Configurations .. "/" .. GameId .. "/autoload.json"
end

local function GetAutoloadConfigNamePath()
	return Folder_Configs.Configurations .. "/" .. GameId .. "/autoload_config.txt"
end

local function GetAutoloadThemeNamePath()
	return Folder_Configs.Themes .. "/autoload_theme.txt"
end

local function GetLocalSettingsPath()
	return Folder_Configs.Datas .. "/" .. GameId .. "/settings.json"
end

for _, folder in ipairs({"solixhub", "solixhub/Datas", "solixhub/Assets", "solixhub/Assets/Audio", "solixhub/Assets/fonts", "solixhub/Configurations", "solixhub/Images", "solixhub/Themes", Folder_Configs.Configurations .. "/" .. GameId, Folder_Configs.Datas .. "/" .. GameId}) do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

Library.Folders = Folder_Configs
Library.Folders_Path = Folder_Configs

local Library do 
	local wait = task.wait
	local spawn = task.spawn
	local delay = task.delay
	local defer = task.defer

	local cloneref = cloneref or function(o) return o end
	local CoreGui = cloneref(game:GetService("CoreGui"))
	local TweenService = cloneref(game:GetService("TweenService"))
	local UserInputService = cloneref(game:GetService("UserInputService"))
	local Players = cloneref(game:GetService("Players"))
	local TextService = cloneref(game:GetService("TextService"))
	local HttpService = cloneref(game:GetService("HttpService"))
	local RunService = cloneref(game:GetService("RunService"))
	local Workspace = cloneref(game:GetService("Workspace"))
	local GuiService = cloneref(game:GetService("GuiService"))
	local ContextActionService = cloneref(game:GetService("ContextActionService"))
	local LocalizationService = cloneref(game:GetService("LocalizationService"))

	local BlockedWindowInputs = {
		Enum.KeyCode.W,
		Enum.KeyCode.A,
		Enum.KeyCode.S,
		Enum.KeyCode.D,
		Enum.KeyCode.Space,
		Enum.KeyCode.LeftShift,
		Enum.KeyCode.RightShift,
		Enum.KeyCode.LeftControl,
		Enum.KeyCode.RightControl,
		Enum.KeyCode.LeftAlt,
		Enum.KeyCode.RightAlt,
		Enum.KeyCode.Up,
		Enum.KeyCode.Down,
		Enum.KeyCode.Left,
		Enum.KeyCode.Right,
		Enum.KeyCode.Return,
		Enum.KeyCode.KeypadEnter,
		Enum.KeyCode.Slash,
		Enum.KeyCode.Backquote,
		Enum.KeyCode.Tab,
		Enum.KeyCode.E,
		Enum.KeyCode.Q,
		Enum.KeyCode.R,
		Enum.KeyCode.F,
		Enum.KeyCode.C,
		Enum.KeyCode.Z,
		Enum.KeyCode.X,
		Enum.KeyCode.One,
		Enum.KeyCode.Two,
		Enum.KeyCode.Three,
		Enum.KeyCode.Four,
		Enum.KeyCode.Five,
		Enum.KeyCode.Six,
		Enum.KeyCode.Seven,
		Enum.KeyCode.Eight,
		Enum.KeyCode.Nine,
		Enum.KeyCode.Zero,
	}

	local GetUI = gethui or function()
		local Success, Result = pcall(function()
			local CoreGui = game:GetService("CoreGui")

			return CoreGui
		end)

		return Success and Result or nil
	end

	local function SafeGetUI()
		local Success, Result = pcall(GetUI)

		if Success and Result then
			return Result
		end

		return game:GetService("CoreGui")
	end

	local LocalPlayer = cloneref(Players.LocalPlayer)
	local Mouse = cloneref(LocalPlayer:GetMouse())

	local Localization do
		local string_lower = string.lower
		local string_sub = string.sub

		local function make_entry(zh, ko, es, ru)
			return { zh = zh, ko = ko, es = es, ru = ru }
		end

		Localization = {
			SourceLanguageCode = "en",
			TranslationsUrl = "https://raw.githubusercontent.com/Ifykyklolololol/djw0a8udw89aijdnoiuwandiuvhwaiudvaw/refs/heads/main/test.lua",
			TranslationsLoaded = false,
			Locale = "en",
			ForcedLocale = nil,
			SupportedLocales = { "en", "zh", "ko", "es", "ru" },
			PlayerTranslator = nil,
			FallbackTranslator = nil,
			HasPlayerTranslator = false,
			HasFallbackTranslator = false,
			Applying = false,
			Registry = {},
			DropdownRegistry = {},
			SliderRegistry = {},
			CustomStrings = {
				zh = {},
				ko = {},
				es = {},
				ru = {},
			},
			BuiltInStrings = {
				["Toggle"] = make_entry("切换", "토글", "Alternar", "Переключить"),
				["Hold"] = make_entry("按住", "홀드", "Mantener", "Удержание"),
				["Always"] = make_entry("始终", "항상", "Siempre", "Всегда"),
				["None"] = make_entry("无", "없음", "Ninguno", "Нет"),
				["Search.."] = make_entry("搜索..", "검색..", "Buscar..", "Поиск.."),
				["Animations"] = make_entry("动画", "애니메이션", "Animaciones", "Анимации"),
				["Keybinds"] = make_entry("按键绑定", "키 바인드", "Atajos", "Горячие клавиши"),
				["Keybind"] = make_entry("按键绑定", "키 바인드", "Atajo", "Гор. клавиша"),
				["press a key"] = make_entry("按一个键", "키를 누르세요", "pulsa una tecla", "нажмите клавишу"),
				["No target"] = make_entry("无目标", "대상 없음", "Sin objetivo", "Нет цели"),
				["Target"] = make_entry("目标", "대상", "Objetivo", "Цель"),
				["Placeholder"] = make_entry("占位符", "플레이스홀더", "Marcador", "Заполнитель"),
				["Enter RGB.."] = make_entry("输入 RGB..", "RGB 입력..", "Introducir RGB..", "Введите RGB.."),
				["Unload"] = make_entry("卸载", "언로드", "Descargar", "Выгрузить"),
				["Menu Setting"] = make_entry("菜单设置", "메뉴 설정", "Ajustes del menú", "Настройки меню"),
				["Menu keybind"] = make_entry("菜单快捷键", "메뉴 키", "Tecla del menú", "Клавиша меню"),
				["open/close menu keybind"] = make_entry("打开/关闭菜单快捷键", "메뉴 열기/닫기 키", "tecla abrir/cerrar menú", "клавиша открыть/закрыть"),
				["Menu Keybind"] = make_entry("菜单快捷键", "메뉴 키", "Tecla del menú", "Клавиша меню"),
				["Background Transparency"] = make_entry("背景透明度", "배경 투명도", "Transparencia del fondo", "Прозрачность фона"),
				["Menu background transparency"] = make_entry("菜单背景透明度", "메뉴 배경 투명도", "Transparencia del fondo del menú", "Прозрачность фона меню"),
				["Menu Tween Time"] = make_entry("菜单动画时间", "메뉴 트윈 시간", "Tiempo de animación", "Время анимации"),
				["Menu animation tween time"] = make_entry("菜单动画缓动时间", "메뉴 애니메이션 시간", "Tiempo de animación del menú", "Время анимации меню"),
				["Menu Fade Time"] = make_entry("菜单淡入淡出时间", "메뉴 페이드 시간", "Tiempo de desvanecimiento", "Время затухания"),
				["Menu fade animation time"] = make_entry("菜单淡入淡出动画时间", "메뉴 페이드 애니메이션 시간", "Tiempo de fade del menú", "Время fade-анимации"),
				["Menu Scale Preset"] = make_entry("菜单缩放预设", "메뉴 크기 프리셋", "Escala del menú", "Масштаб меню"),
				["Select Menu scale preset"] = make_entry("选择菜单缩放预设", "메뉴 크기 프리셋 선택", "Seleccionar escala del menú", "Выберите масштаб меню"),
				["Menu Tween Style"] = make_entry("菜单缓动样式", "메뉴 트윈 스타일", "Estilo de animación", "Стиль анимации"),
				["Menu animation easing style"] = make_entry("菜单动画缓动样式", "메뉴 애니메이션 이징", "Estilo de easing del menú", "Стиль easing меню"),
				["Menu Tween Direction"] = make_entry("菜单缓动方向", "메뉴 트윈 방향", "Dirección de animación", "Направление анимации"),
				["Menu animation easing direction"] = make_entry("菜单动画缓动方向", "메뉴 애니메이션 방향", "Dirección de easing del menú", "Направление easing меню"),
				["Show Watermark"] = make_entry("显示水印", "워터마크 표시", "Mostrar marca de agua", "Показать водяной знак"),
				["Show/hide the Watermark"] = make_entry("显示/隐藏水印", "워터마크 표시/숨기기", "Mostrar/ocultar marca de agua", "Показать/скрыть водяной знак"),
				["Show Keybind List"] = make_entry("显示按键列表", "키 목록 표시", "Mostrar lista de atajos", "Показать список клавиш"),
				["Show/hide list of all keybinds"] = make_entry("显示/隐藏所有按键绑定", "모든 키 바인드 표시/숨기기", "Mostrar/ocultar atajos", "Показать/скрыть все клавиши"),
				["Show Menu Button"] = make_entry("显示菜单按钮", "메뉴 버튼 표시", "Mostrar botón del menú", "Показать кнопку меню"),
				["Show/hide the menu open button"] = make_entry("显示/隐藏菜单打开按钮", "메뉴 열기 버튼 표시/숨기기", "Mostrar/ocultar botón del menú", "Показать/скрыть кнопку меню"),
				["Background Darken"] = make_entry("背景变暗", "배경 어둡게", "Oscurecer fondo", "Затемнение фона"),
				["Dark overlay/blur while menu is open"] = make_entry("菜单打开时背景变暗/模糊", "메뉴 열릴 때 배경 어둡게", "Oscurecer al abrir menú", "Затемнение при открытии меню"),
				["Background Effect"] = make_entry("背景效果", "배경 효과", "Efecto de fondo", "Эффект фона"),
				["Particle effect behind the menu"] = make_entry("菜单后方粒子效果", "메뉴 뒤 파티클 효과", "Efecto de partículas", "Эффект частиц за меню"),
				["Auto Save Config"] = make_entry("自动保存配置", "자동 저장", "Guardar automáticamente", "Автосохранение"),
				["Automatically save your config"] = make_entry("自动保存你的配置", "설정 자동 저장", "Guardar config automáticamente", "Автосохранение конфига"),
				["Snow"] = make_entry("雪花", "눈", "Nieve", "Снег"),
				["Rain"] = make_entry("雨", "비", "Lluvia", "Дождь"),
				["Lifetime"] = make_entry("永久", "평생", "De por vida", "Навсегда"),
				["No Key"] = make_entry("无密钥", "키 없음", "Sin clave", "Нет ключа"),
				["Very Small"] = make_entry("非常小", "아주 작게", "Muy pequeño", "Очень мало"),
				["Small"] = make_entry("小", "작게", "Pequeño", "Мало"),
				["Medium"] = make_entry("中", "보통", "Mediano", "Средне"),
				["Large"] = make_entry("大", "크게", "Grande", "Большой"),
				["Bigger"] = make_entry("更大", "더 크게", "Más grande", "Больше"),
				["Massive"] = make_entry("巨大", "매우 크게", "Enorme", "Огромный"),
				["Linear"] = make_entry("线性", "선형", "Lineal", "Линейный"),
				["Sine"] = make_entry("正弦", "사인", "Seno", "Синус"),
				["Quad"] = make_entry("二次", "쿼드", "Cuadrático", "Квадрат"),
				["Cubic"] = make_entry("三次", "큐빅", "Cúbico", "Кубический"),
				["Quart"] = make_entry("四次", "쿼트", "Cuártico", "Четвёртый"),
				["Quint"] = make_entry("五次", "퀸트", "Quíntico", "Пятый"),
				["Exponential"] = make_entry("指数", "지수", "Exponencial", "Экспоненциальный"),
				["Circular"] = make_entry("圆形", "원형", "Circular", "Круговой"),
				["Back"] = make_entry("回弹", "백", "Retroceso", "Откат"),
				["Elastic"] = make_entry("弹性", "탄성", "Elástico", "Упругий"),
				["Bounce"] = make_entry("弹跳", "바운스", "Rebote", "Отскок"),
				["In"] = make_entry("入", "인", "Entrada", "Вход"),
				["Out"] = make_entry("出", "아웃", "Salida", "Выход"),
				["InOut"] = make_entry("入出", "인아웃", "Entrada/Salida", "Вход/Выход"),
				["Active"] = make_entry("启用", "활성", "Activo", "Активно"),
				["Inactive"] = make_entry("禁用", "비활성", "Inactivo", "Неактивно"),
				["Window"] = make_entry("窗口", "창", "Ventana", "Окно"),
				["Page"] = make_entry("页面", "페이지", "Página", "Страница"),
				["Tab"] = make_entry("标签", "탭", "Pestaña", "Вкладка"),
				["Section"] = make_entry("分区", "섹션", "Sección", "Секция"),
				["Label"] = make_entry("标签", "라벨", "Etiqueta", "Метка"),
				["Checkbox"] = make_entry("复选框", "체크박스", "Casilla", "Флажок"),
				["Slider"] = make_entry("滑块", "슬라이더", "Deslizador", "Ползунок"),
				["Dropdown"] = make_entry("下拉框", "드롭다운", "Desplegable", "Выпадающий"),
				["Textbox"] = make_entry("文本框", "텍스트박스", "Cuadro de texto", "Текстовое поле"),
				["Button"] = make_entry("按钮", "버튼", "Botón", "Кнопка"),
				["Model Viewer"] = make_entry("模型查看器", "모델 뷰어", "Visor de modelos", "Просмотр модели"),
				["Font Setting"] = make_entry("字体设置", "글꼴 설정", "Ajuste de fuente", "Настройка шрифта"),
				["Settings"] = make_entry("设置", "설정", "Ajustes", "Настройки"),
				["Config"] = make_entry("配置", "설정", "Configuración", "Конфиг"),
				["Theme"] = make_entry("主题", "테마", "Tema", "Тема"),
				["Share Config"] = make_entry("分享配置", "설정 공유", "Compartir config", "Поделиться конфигом"),
				["Import Pasted"] = make_entry("导入粘贴", "붙여넣기 가져오기", "Importar pegado", "Импорт из буфера"),
				["Paste config here..."] = make_entry("在此粘贴配置...", "설정 붙여넣기...", "Pegar config aquí...", "Вставьте конфиг..."),
				["Press Enter after pasting!"] = make_entry("粘贴后按 Enter！", "붙여넣은 후 Enter!", "¡Pulsa Enter tras pegar!", "Нажмите Enter после вставки!"),
				["Language"] = make_entry("语言", "언어", "Idioma", "Язык"),
				["Select menu language"] = make_entry("选择菜单语言", "메뉴 언어 선택", "Seleccionar idioma del menú", "Выберите язык меню"),
				["Auto"] = make_entry("自动", "자동", "Automático", "Авто"),
				["English"] = make_entry("英语", "영어", "Inglés", "Английский"),
				["Chinese"] = make_entry("中文", "중국어", "Chino", "Китайский"),
				["Korean"] = make_entry("韩语", "한국어", "Coreano", "Корейский"),
				["Spanish"] = make_entry("西班牙语", "스페인어", "Español", "Испанский"),
				["Russian"] = make_entry("俄语", "러시아어", "Ruso", "Русский"),
				["Settings"] = make_entry("设置", "설정", "Ajustes", "Настройки"),
				["Account"] = make_entry("账户", "계정", "Cuenta", "Аккаунт"),
				["Themes"] = make_entry("主题", "테마", "Temas", "Темы"),
				["Menu"] = make_entry("菜单", "메뉴", "Menú", "Меню"),
				["Configurations"] = make_entry("配置", "설정", "Configuraciones", "Конфигурации"),
				["Player Info"] = make_entry("玩家信息", "플레이어 정보", "Info del jugador", "Информация игрока"),
				["Theme Setting"] = make_entry("主题设置", "테마 설정", "Ajuste de tema", "Настройка темы"),
				["Theme Config"] = make_entry("主题配置", "테마 구성", "Config de tema", "Конфиг темы"),
				["Border"] = make_entry("边框", "테두리", "Borde", "Граница"),
				["Inline"] = make_entry("内联", "인라인", "Inline", "Inline"),
				["Inactive Text"] = make_entry("非激活文字", "비활성 텍스트", "Texto inactivo", "Неактивный текст"),
				["Background"] = make_entry("背景", "배경", "Fondo", "Фон"),
				["Element"] = make_entry("元素", "요소", "Elemento", "Элемент"),
				["Accent"] = make_entry("强调色", "강조색", "Acento", "Акцент"),
				["Shadow"] = make_entry("阴影", "그림자", "Sombra", "Тень"),
				["Gradient"] = make_entry("渐变", "그라데이션", "Degradado", "Градиент"),
				["border"] = make_entry("边框", "테두리", "borde", "граница"),
				["inline"] = make_entry("内联", "인라인", "inline", "inline"),
				["background"] = make_entry("背景", "배경", "fondo", "фон"),
				["element"] = make_entry("元素", "요소", "elemento", "элемент"),
				["accent"] = make_entry("强调色", "강조색", "acento", "акцент"),
				["shadow"] = make_entry("阴影", "그림자", "sombra", "тень"),
				["gradient"] = make_entry("渐变", "그라데이션", "degradado", "градиент"),
				["inactive text"] = make_entry("非激活文字", "비활성 텍스트", "texto inactivo", "неактивный текст"),
				["Themes Select"] = make_entry("选择主题", "테마 선택", "Seleccionar tema", "Выбор темы"),
				["Select a theme preset"] = make_entry("选择主题预设", "테마 프리셋 선택", "Seleccionar preset de tema", "Выберите пресет темы"),
				["Autoload Theme"] = make_entry("自动加载主题", "테마 자동 로드", "Autocargar tema", "Автозагрузка темы"),
				["Autoloads the selected theme on next load"] = make_entry("下次加载时自动加载所选主题", "다음 로드 시 선택한 테마 자동 로드", "Autocarga el tema al iniciar", "Автозагрузка темы при запуске"),
				["Theme Name"] = make_entry("主题名称", "테마 이름", "Nombre del tema", "Имя темы"),
				["Enter a name for your theme"] = make_entry("输入主题名称", "테마 이름 입력", "Introduce un nombre", "Введите имя темы"),
				["Theme name..."] = make_entry("主题名称...", "테마 이름...", "Nombre del tema...", "Имя темы..."),
				["Themes Preset"] = make_entry("主题预设", "테마 프리셋", "Preset de temas", "Пресет тем"),
				["Select a theme"] = make_entry("选择主题", "테마 선택", "Seleccionar tema", "Выберите тему"),
				["Create"] = make_entry("创建", "생성", "Crear", "Создать"),
				["Delete"] = make_entry("删除", "삭제", "Eliminar", "Удалить"),
				["Load"] = make_entry("加载", "로드", "Cargar", "Загрузить"),
				["Save"] = make_entry("保存", "저장", "Guardar", "Сохранить"),
				["Refresh"] = make_entry("刷新", "새로고침", "Actualizar", "Обновить"),
				["Success"] = make_entry("成功", "성공", "Éxito", "Успех"),
				["Error"] = make_entry("错误", "오류", "Error", "Ошибка"),
				["Font Error"] = make_entry("字体错误", "글꼴 오류", "Error de fuente", "Ошибка шрифта"),
				["List of fonts to use on the Solix Hub UI"] = make_entry("Solix Hub UI 可用字体列表", "Solix Hub UI 글꼴 목록", "Fuentes disponibles en Solix Hub", "Шрифты для Solix Hub UI"),
				["Safe Mode"] = make_entry("安全模式", "안전 모드", "Modo seguro", "Безопасный режим"),
				["Auto Hides Ui On Execute"] = make_entry("执行时自动隐藏UI", "실행 시 UI 자동 숨김", "Oculta UI al ejecutar", "Скрывает UI при запуске"),
				["Auto Execute"] = make_entry("自动执行", "자동 실행", "Auto ejecutar", "Автозапуск"),
				["Auto execute script after teleport"] = make_entry("传送后自动执行脚本", "텔레포트 후 자동 실행", "Auto ejecutar tras teletransporte", "Автозапуск после телепорта"),
				["Server"] = make_entry("服务器", "서버", "Servidor", "Сервер"),
				["Rejoin"] = make_entry("重新加入", "재접속", "Reunirse", "Перезайти"),
				["Server Hop"] = make_entry("切换服务器", "서버 이동", "Cambiar servidor", "Сменить сервер"),
				["Copy Place ID"] = make_entry("复制 Place ID", "Place ID 복사", "Copiar Place ID", "Копировать Place ID"),
				["Copy Game ID"] = make_entry("复制 Game ID", "Game ID 복사", "Copiar Game ID", "Копировать Game ID"),
				["Copy Job ID"] = make_entry("复制 Job ID", "Job ID 복사", "Copiar Job ID", "Копировать Job ID"),
				["Copy Join Code"] = make_entry("复制加入码", "참가 코드 복사", "Copiar código", "Копировать код"),
				["Script Config"] = make_entry("脚本配置", "스크립트 설정", "Config del script", "Конфиг скрипта"),
				["Config Select"] = make_entry("选择配置", "설정 선택", "Seleccionar config", "Выбор конфига"),
				["List of the Configurations"] = make_entry("配置列表", "설정 목록", "Lista de configuraciones", "Список конфигов"),
				["Autoload Configuration"] = make_entry("自动加载配置", "설정 자동 로드", "Autocargar config", "Автозагрузка конфига"),
				["Autoloads the selected configuration on next load"] = make_entry("下次加载时自动加载所选配置", "다음 로드 시 선택한 설정 자동 로드", "Autocarga config al iniciar", "Автозагрузка конфига при запуске"),
				["Config Name"] = make_entry("配置名称", "설정 이름", "Nombre del config", "Имя конфига"),
				["Name of the config"] = make_entry("配置的名称", "설정 이름", "Nombre de la config", "Название конфига"),
				["Set Autoload"] = make_entry("设为自动加载", "자동 로드 설정", "Establecer autoload", "Установить автозагрузку"),
				["Remove Autoload"] = make_entry("移除自动加载", "자동 로드 제거", "Quitar autoload", "Убрать автозагрузку"),
				["Paste Shared Config"] = make_entry("粘贴分享的配置", "공유 설정 붙여넣기", "Pegar config compartida", "Вставить общий конфиг"),
				["Please select a theme first"] = make_entry("请先选择主题", "먼저 테마를 선택하세요", "Selecciona un tema primero", "Сначала выберите тему"),
				["Please select a config first"] = make_entry("请先选择配置", "먼저 설정을 선택하세요", "Selecciona un config primero", "Сначала выберите конфиг"),
				["Solix"] = make_entry("Solix", "Solix", "Solix", "Solix"),
				["Fatality"] = make_entry("Fatality", "Fatality", "Fatality", "Fatality"),
				["Primordial"] = make_entry("Primordial", "Primordial", "Primordial", "Primordial"),
				["Pandora"] = make_entry("Pandora", "Pandora", "Pandora", "Pandora"),
				["Skeet"] = make_entry("Skeet", "Skeet", "Skeet", "Skeet"),
				["Rifk"] = make_entry("Rifk", "Rifk", "Rifk", "Rifk"),
				["Rainbow"] = make_entry("彩虹", "무지개", "Arcoíris", "Радуга"),
				["Breathing"] = make_entry("呼吸", "브리딩", "Respiración", "Дыхание"),
				["Font Setting"] = make_entry("字体设置", "글꼴 설정", "Ajuste de fuente", "Настройка шрифта"),
			},
			PrefixStrings = {
				[" theme color"] = make_entry(" 主题色", " 테마 색상", " color de tema", " цвет темы"),
				["Note: "] = make_entry("备注: ", "메모: ", "Nota: ", "Примечание: "),
				["Expires: "] = make_entry("过期: ", "만료: ", "Expira: ", "Истекает: "),
				["Executions: "] = make_entry("执行次数: ", "실행 횟수: ", "Ejecuciones: ", "Запусков: "),
				["Username: "] = make_entry("用户名: ", "사용자: ", "Usuario: ", "Имя: "),
				["UserId: "] = make_entry("用户ID: ", "유저 ID: ", "ID de usuario: ", "ID: "),
				["Account Age: "] = make_entry("账号年龄: ", "계정 나이: ", "Antigüedad: ", "Возраст аккаунта: "),
				["PlaceId: "] = make_entry("PlaceId: ", "PlaceId: ", "PlaceId: ", "PlaceId: "),
			},
		}

		function Localization:NormalizeLocaleId(LocaleId)
			if type(LocaleId) ~= "string" or LocaleId == "" then
				return "en"
			end

			LocaleId = string_lower(LocaleId)

			if string_sub(LocaleId, 1, 2) == "zh" then
				return "zh"
			elseif string_sub(LocaleId, 1, 2) == "ko" then
				return "ko"
			elseif string_sub(LocaleId, 1, 2) == "es" then
				return "es"
			elseif string_sub(LocaleId, 1, 2) == "ru" then
				return "ru"
			end

			return "en"
		end

		function Localization:GetActiveLocale()
			if self.ForcedLocale then
				return self.ForcedLocale
			end

			return self.Locale or "en"
		end

		function Localization:SetLanguage(LocaleCode)
			if type(LocaleCode) ~= "string" or LocaleCode == "" then
				return false
			end

			if string_lower(LocaleCode) == "auto" then
				self.ForcedLocale = nil
				self:RefreshAll()
				return true
			end

			local Normalized = self:NormalizeLocaleId(LocaleCode)

			if Normalized == "en" and string_lower(LocaleCode) ~= "en" and string_lower(LocaleCode) ~= "en-us" then
				return false
			end

			self.ForcedLocale = Normalized
			self:RefreshAll()
			return true
		end

		function Localization:ClearCustomStrings()
			for locale_code, _ in pairs(self.CustomStrings) do
				self.CustomStrings[locale_code] = {}
			end
		end

		function Localization:LoadRemoteTranslations(Url)
			Url = Url or self.TranslationsUrl

			if type(Url) ~= "string" or Url == "" then
				return false
			end

			local fetch_url = Url
			local cache_buster = tostring(os.time()) .. tostring(math.random(100000, 999999))
			if fetch_url:find("?", 1, true) then
				fetch_url = fetch_url .. "&solix_ts=" .. cache_buster
			else
				fetch_url = fetch_url .. "?solix_ts=" .. cache_buster
			end

			local Success = pcall(function()
				local Source = game:HttpGet(fetch_url)

				if type(Source) ~= "string" or Source == "" then
					return
				end

				local Chunk = loadstring(Source)

				if Chunk then
					Chunk()
				end
			end)

			self.TranslationsLoaded = Success == true
			return self.TranslationsLoaded
		end

		function Localization:ReloadRemoteTranslations(Url)
			self:ClearCustomStrings()
			local loaded = self:LoadRemoteTranslations(Url)
			self:RefreshAll()
			return loaded
		end

		function Localization:RefreshNamedElements()
			if type(Library) ~= "table" then
				return
			end

			local visited_windows = {}

			local function refresh_page_tree(sidebar_page)
				if type(sidebar_page) ~= "table" then
					return
				end

				local page_items = sidebar_page.Items
				if type(page_items) == "table" and page_items["Text"] and page_items["Text"].Instance then
					self:ApplyText(page_items["Text"].Instance, sidebar_page.Name, "Text")
				end

				if type(sidebar_page.SubPages) == "table" then
					for _, sub_page in ipairs(sidebar_page.SubPages) do
						local sub_page_items = sub_page.Items
						if type(sub_page_items) == "table" then
							if sub_page_items["TabText"] and sub_page_items["TabText"].Instance then
								self:ApplyText(sub_page_items["TabText"].Instance, sub_page.Name, "Text")
							end
							if sub_page_items["TabSizer"] and sub_page_items["TabSizer"].Instance then
								self:ApplyText(sub_page_items["TabSizer"].Instance, sub_page.Name, "Text")
							end
						end
					end
				end
			end

			for _, section in ipairs(Library.AllSections or {}) do
				if type(section) ~= "table" then
					continue
				end

				local section_items = section.Items
				if type(section_items) == "table" and section_items["Text"] and section_items["Text"].Instance then
					self:ApplyText(section_items["Text"].Instance, section.Name, "Text")
				end

				local page = section.Page
				local window = page and page.Window or nil
				if window and not visited_windows[window] then
					visited_windows[window] = true
					if type(window.Pages) == "table" then
						for _, sidebar_page in ipairs(window.Pages) do
							refresh_page_tree(sidebar_page)
						end
					end
				end
			end
		end

		function Localization:GetLanguage()
			return self:GetActiveLocale()
		end

		function Localization:AddStrings(LocaleCode, StringsTable)
			if type(LocaleCode) ~= "string" or type(StringsTable) ~= "table" then
				return false
			end

			local Normalized = self:NormalizeLocaleId(LocaleCode)

			if not self.CustomStrings[Normalized] then
				self.CustomStrings[Normalized] = {}
			end

			for SourceText, Translation in pairs(StringsTable) do
				if type(SourceText) == "string" and type(Translation) == "string" then
					self.CustomStrings[Normalized][SourceText] = Translation
				end
			end

			if Normalized == self:GetActiveLocale() then
				self:RefreshAll()
			end

			return true
		end

		function Localization:LookupTranslation(Text)
			if type(Text) ~= "string" or Text == "" then
				return nil
			end

			local ActiveLocale = self:GetActiveLocale()
			if ActiveLocale == "en" then
				return nil
			end

			local Custom = self.CustomStrings[ActiveLocale] and self.CustomStrings[ActiveLocale][Text]
			if Custom then
				return Custom
			end

			local BuiltIn = self.BuiltInStrings[Text]
			if BuiltIn and BuiltIn[ActiveLocale] then
				return BuiltIn[ActiveLocale]
			end

			return nil
		end

		function Localization:TranslateBuiltIn(Text)
			local ActiveLocale = self:GetActiveLocale()

			if ActiveLocale == "en" then
				return nil
			end

			local Direct = self:LookupTranslation(Text)
			if Direct then
				return Direct
			end

			local ThemeColorSuffix = " theme color"
			if Text:sub(-#ThemeColorSuffix) == ThemeColorSuffix then
				local Prefix = Text:sub(1, #Text - #ThemeColorSuffix)
				local TranslatedPrefix = self:LookupTranslation(Prefix)
					or self:LookupTranslation(Prefix:sub(1, 1):upper() .. Prefix:sub(2))
					or self:LookupTranslation(Prefix:gsub("^%l", string.upper))

				if TranslatedPrefix then
					local SuffixEntry = self.PrefixStrings[ThemeColorSuffix]
					local TranslatedSuffix = SuffixEntry and SuffixEntry[ActiveLocale] or ThemeColorSuffix
					return TranslatedPrefix .. TranslatedSuffix
				end
			end

			for Prefix, Translations in pairs(self.PrefixStrings) do
				if Text:sub(1, #Prefix) == Prefix then
					local TranslatedPrefix = Translations[ActiveLocale]
					if TranslatedPrefix then
						return TranslatedPrefix .. Text:sub(#Prefix + 1)
					end
				end
			end

			return nil
		end

		function Localization:ShouldSkipTranslate(Text)
			if type(Text) ~= "string" or Text == "" then
				return true
			end

			if Text:match("^rbxassetid://") or Text:match("^%d+$") or Text:match("^%d+,%s*%d+,%s*%d+$") then
				return true
			end

			return false
		end

		function Localization:Translate(Text, Context)
			if self:ShouldSkipTranslate(Text) then
				return Text
			end

			local BuiltInTranslation = self:TranslateBuiltIn(Text)
			if BuiltInTranslation then
				return BuiltInTranslation
			end

			Context = Context or game

			if self.HasPlayerTranslator and self.PlayerTranslator then
				local Success, Result = pcall(function()
					return self.PlayerTranslator:Translate(Context, Text)
				end)

				if Success and type(Result) == "string" then
					return Result
				end
			end

			if self.HasFallbackTranslator and self.FallbackTranslator then
				local Success, Result = pcall(function()
					return self.FallbackTranslator:Translate(Context, Text)
				end)

				if Success and type(Result) == "string" then
					return Result
				end
			end

			return Text
		end

		function Localization:FormatByKey(Key, Arguments)
			if type(Key) ~= "string" or Key == "" then
				return Key
			end

			local Translation = nil
			local FoundTranslation = false

			if self.HasPlayerTranslator and self.PlayerTranslator then
				FoundTranslation = pcall(function()
					Translation = self.PlayerTranslator:FormatByKey(Key, Arguments)
				end)
			end

			if not FoundTranslation and self.HasFallbackTranslator and self.FallbackTranslator then
				FoundTranslation = pcall(function()
					Translation = self.FallbackTranslator:FormatByKey(Key, Arguments)
				end)
			end

			if FoundTranslation and type(Translation) == "string" then
				return Translation
			end

			return Key
		end

		function Localization:FindEnglishKey(Text)
			if type(Text) ~= "string" or Text == "" then
				return Text
			end

			if self.BuiltInStrings[Text] then
				return Text
			end

			for _, StringsTable in pairs(self.CustomStrings) do
				if StringsTable[Text] then
					return Text
				end

				for SourceKey, Translation in pairs(StringsTable) do
					if Translation == Text then
						return SourceKey
					end
				end
			end

			for SourceKey, Translations in pairs(self.BuiltInStrings) do
				for _, Locale in ipairs(self.SupportedLocales) do
					if Translations[Locale] == Text then
						return SourceKey
					end
				end
			end

			return Text
		end

		function Localization:GetOriginalText(Instance, Property)
			if not Instance then
				return nil
			end

			local OriginalText = Instance:GetAttribute("SolixOriginal_" .. Property)
			if type(OriginalText) == "string" and OriginalText ~= "" then
				return OriginalText
			end

			local SourceText = Instance:GetAttribute("SolixSource_" .. Property)
			if type(SourceText) ~= "string" or SourceText == "" then
				return nil
			end

			local EnglishKey = self:FindEnglishKey(SourceText)
			Instance:SetAttribute("SolixOriginal_" .. Property, EnglishKey)

			return EnglishKey
		end

		function Localization:IsTranslatedDisplay(SourceText, CurrentText, Instance)
			if SourceText == CurrentText then
				return true
			end

			return CurrentText == self:Translate(SourceText, Instance)
		end

		function Localization:Register(Instance, Property)
			if not Instance then
				return
			end

			local RegistryKey = tostring(Instance) .. "_" .. Property

			if not self.Registry[RegistryKey] then
				self.Registry[RegistryKey] = {
					Instance = Instance,
					Property = Property,
				}
			end
		end

		function Localization:ApplyText(Instance, SourceText, Property)
			if not Instance or not Instance.Parent then
				return
			end

			Property = Property or "Text"

			if Property ~= "Text" and Property ~= "PlaceholderText" then
				return
			end

			if type(SourceText) ~= "string" then
				SourceText = tostring(SourceText or "")
			end

			Instance:SetAttribute("SolixOriginal_" .. Property, SourceText)
			Instance:SetAttribute("SolixSource_" .. Property, SourceText)

			self.Applying = true
			Instance[Property] = self:Translate(SourceText, Instance)
			self.Applying = false

			self:Register(Instance, Property)
		end

		function Localization:RegisterDropdown(Dropdown, ValueInstance)
			if not Dropdown or not ValueInstance then
				return
			end

			self.DropdownRegistry[Dropdown] = ValueInstance
		end

		function Localization:SetDropdownDisplay(Dropdown, ValueInstance)
			if not Dropdown or not ValueInstance then
				return
			end

			if Dropdown.Multi then
				ValueInstance:SetAttribute("SolixDropdownMulti", true)

				local TranslatedParts = {}

				if type(Dropdown.Value) == "table" then
					for _, OptionName in ipairs(Dropdown.Value) do
						TranslatedParts[#TranslatedParts + 1] = self:Translate(tostring(OptionName), ValueInstance)
					end
				end

				self.Applying = true
				ValueInstance.Text = #TranslatedParts > 0 and table.concat(TranslatedParts, ", ") or self:Translate("...", ValueInstance)
				self.Applying = false
				self:Register(ValueInstance, "Text")
			elseif type(Dropdown.Value) == "table" then
				ValueInstance:SetAttribute("SolixDropdownMulti", nil)
				self:ApplyText(ValueInstance, "...", "Text")
			elseif Dropdown.Value ~= nil and Dropdown.Value ~= "" then
				ValueInstance:SetAttribute("SolixDropdownMulti", nil)
				self:ApplyText(ValueInstance, tostring(Dropdown.Value), "Text")
			else
				ValueInstance:SetAttribute("SolixDropdownMulti", nil)
				self:ApplyText(ValueInstance, "...", "Text")
			end
		end

		function Localization:RefreshDropdowns()
			for Dropdown, ValueInstance in pairs(self.DropdownRegistry) do
				if not ValueInstance or not ValueInstance.Parent then
					continue
				end

				self:SetDropdownDisplay(Dropdown, ValueInstance)

				if type(Dropdown.Options) == "table" then
					for OptionName, OptionData in pairs(Dropdown.Options) do
						if OptionData.Text and OptionData.Text.Instance then
							self:ApplyText(OptionData.Text.Instance, tostring(OptionName), "Text")
						end
					end
				end
			end
		end

		function Localization:RegisterSlider(Slider, TrackLabelInstance, Name, Suffix)
			if not Slider or not TrackLabelInstance then
				return
			end

			self.SliderRegistry[Slider] = {
				TrackLabel = TrackLabelInstance,
				Name = Name or "",
				Suffix = Suffix or "",
			}
		end

		function Localization:UpdateSliderTrackLabel(Slider, TrackLabel, Name, Suffix)
			if not TrackLabel or not TrackLabel.Parent or type(Slider.Value) ~= "number" then
				return
			end

			TrackLabel:SetAttribute("SolixSliderLabel", true)

			local DisplayValue = string.format("%g", Slider.Value)
			local TranslatedName = string.lower(self:Translate(Name, TrackLabel))
			local LabelText = TranslatedName .. ": " .. DisplayValue .. Suffix

			self.Applying = true
			TrackLabel.Text = LabelText
			self.Applying = false
			self:Register(TrackLabel, "Text")
		end

		function Localization:RefreshSliders()
			for Slider, Entry in pairs(self.SliderRegistry) do
				self:UpdateSliderTrackLabel(Slider, Entry.TrackLabel, Entry.Name, Entry.Suffix)
			end
		end

		function Localization:GetRefreshRoots()
			local Roots = {}

			local function add_root(RootInstance)
				if typeof(RootInstance) == "Instance" then
					Roots[#Roots + 1] = RootInstance
				end
			end

			if Library then
				if Library.Holder and Library.Holder.Instance then
					add_root(Library.Holder.Instance)
				end

				if Library.OtherHolder and Library.OtherHolder.Instance then
					add_root(Library.OtherHolder.Instance)
				end

				if Library.FloatingButtonHolder and Library.FloatingButtonHolder.Instance then
					add_root(Library.FloatingButtonHolder.Instance)
				end

				if Library.WatermarkGui and Library.WatermarkGui.Instance then
					add_root(Library.WatermarkGui.Instance)
				end

				if Library.InputBlockGui and Library.InputBlockGui.Instance then
					add_root(Library.InputBlockGui.Instance)
				end

				if Library.CursorGui and Library.CursorGui.Instance then
					add_root(Library.CursorGui.Instance)
				end
			end

			return Roots
		end

		function Localization:ApplyStoredText(Instance, Property)
			if not Instance or not Instance.Parent then
				return
			end

			if Instance:GetAttribute("SolixDropdownMulti") or Instance:GetAttribute("SolixSliderLabel") then
				return
			end

			local SourceText = self:GetOriginalText(Instance, Property)
			if SourceText == nil then
				return
			end

			Instance:SetAttribute("SolixSource_" .. Property, SourceText)

			self.Applying = true
			Instance[Property] = self:Translate(SourceText, Instance)
			self.Applying = false
			self:Register(Instance, Property)
		end

		function Localization:RefreshInstanceTree(Root)
			if not Root then
				return
			end

			for _, Descendant in ipairs(Root:GetDescendants()) do
				if Descendant:IsA("TextLabel") or Descendant:IsA("TextButton") then
					self:ApplyStoredText(Descendant, "Text")
				elseif Descendant:IsA("TextBox") then
					self:ApplyStoredText(Descendant, "PlaceholderText")
				end
			end
		end

		function Localization:RefreshAll()
			for _, Entry in pairs(self.Registry) do
				self:ApplyStoredText(Entry.Instance, Entry.Property)
			end

			self:RefreshNamedElements()
			self:RefreshDropdowns()
			self:RefreshSliders()

			for _, Root in ipairs(self:GetRefreshRoots()) do
				self:RefreshInstanceTree(Root)
			end
		end

		function Localization:HookTextInstance(Instance, Properties)
			if not Instance then
				return
			end

			for _, Property in ipairs(Properties) do
				if Property == "PlaceholderText" and not Instance:IsA("TextBox") then
					-- skip
				else
					Instance:GetPropertyChangedSignal(Property):Connect(function()
						if self.Applying then
							return
						end

						local OriginalText = self:GetOriginalText(Instance, Property)
						local CurrentText = Instance[Property]

						if OriginalText == nil then
							return
						end

						if self:IsTranslatedDisplay(OriginalText, CurrentText, Instance) then
							return
						end

						if OriginalText == CurrentText then
							return
						end

						self:ApplyText(Instance, self:FindEnglishKey(CurrentText), Property)
					end)
				end
			end
		end

		function Localization:Init()
			self.Locale = "en"

			local SuccessRobloxLocale, RobloxLocaleId = pcall(function()
				return LocalizationService.RobloxLocaleId
			end)

			if SuccessRobloxLocale and type(RobloxLocaleId) == "string" then
				self.Locale = self:NormalizeLocaleId(RobloxLocaleId)
			end

			local SuccessPlayer, PlayerTranslator = pcall(function()
				return LocalizationService:GetTranslatorForPlayerAsync(LocalPlayer)
			end)

			if SuccessPlayer and PlayerTranslator then
				self.PlayerTranslator = PlayerTranslator
				self.HasPlayerTranslator = true
				self.Locale = self:NormalizeLocaleId(PlayerTranslator.LocaleId)

				self.PlayerTranslator:GetPropertyChangedSignal("LocaleId"):Connect(function()
					if not self.ForcedLocale then
						self.Locale = self:NormalizeLocaleId(self.PlayerTranslator.LocaleId)
					end
					self:RefreshAll()
				end)
			end

			local SuccessFallback, FallbackTranslator = pcall(function()
				return LocalizationService:GetTranslatorForLocaleAsync(self.SourceLanguageCode)
			end)

			if SuccessFallback and FallbackTranslator then
				self.FallbackTranslator = FallbackTranslator
				self.HasFallbackTranslator = true
			end

			self:RefreshAll()
		end

		function Localization:Clear()
			table.clear(self.Registry)
			self.PlayerTranslator = nil
			self.FallbackTranslator = nil
			self.HasPlayerTranslator = false
			self.HasFallbackTranslator = false
		end
	end

	local function GetMouseLocation()
		return cloneref(UserInputService):GetMouseLocation()
	end

	local FromRGB = Color3.fromRGB
	local FromHSV = Color3.fromHSV
	local FromHex = Color3.fromHex

	local RGBSequence = ColorSequence.new
	local RGBSequenceKeypoint = ColorSequenceKeypoint.new
	local NumSequence = NumberSequence.new
	local NumSequenceKeypoint = NumberSequenceKeypoint.new

	local UDim2New = UDim2.new
	local UDimNew = UDim.new
	local UDim2FromOffset = UDim2.fromOffset
	local Vector2New = Vector2.new
	local Vector3New = Vector3.new

	local function GetDragScale(Gui)
		if Library.Holder and Library.Holder.Instance and Gui:IsDescendantOf(Library.Holder.Instance) then
			return Library.UIScaleNum or 1
		end

		return 1
	end

	local function NormalizeDragPosition(Gui)
		local Parent = Gui.Parent

		if not Parent or not Parent:IsA("GuiObject") then
			return
		end

		local Scale = GetDragScale(Gui)
		local AbsPos = Gui.AbsolutePosition
		local ParentAbs = Parent.AbsolutePosition

		Gui.AnchorPoint = Vector2New(0, 0)
		Gui.Position = UDim2FromOffset(
			(AbsPos.X - ParentAbs.X) / Scale,
			(AbsPos.Y - ParentAbs.Y) / Scale
		)
	end

	local MathClamp = math.clamp
	local MathFloor = math.floor
	local MathAbs = math.abs
	local MathSin = math.sin

	local TableInsert = table.insert
	local TableFind = table.find
	local TableRemove = table.remove
	local TableConcat = table.concat
	local TableClone = table.clone
	local TableUnpack = table.unpack

	local StringFormat = string.format
	local StringFind = string.find
	local StringGSub = string.gsub
	local StringLower = string.lower
	local StringLen = string.len

	local InstanceNew = Instance.new

	local RectNew = Rect.new

	local IsMobile = false

	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
		IsMobile = true
	elseif not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
		IsMobile = false
	elseif UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then 
		IsMobile = false
	end 

	Library = {
		Theme =  {},

		MenuKeybind = tostring(Enum.KeyCode.RightControl),

		Flags = {},

		Tween = {
			Time = 0.3,
			Style = Enum.EasingStyle.Quad,
			Direction = Enum.EasingDirection.Out
		},

		FadeSpeed = 0.2,

		BackgroundTransparency = 0,

		Folders_Path = {
			Directory = "solixhub",
			Assets = "solixhub/Assets",
			Configurations = "solixhub/Configurations",
			Datas = "solixhub/Datas",
			Images = "solixhub/Images",
			Themes = "solixhub/Themes"
		},

		Pages = {},
		Sections = {},

		Windows = {},
		AllSections = {},

		SearchItems = {},
		CurrentPage = nil,

		Connections = {},
		Threads = {},

		ThemeMap = {},
		ThemeItems = {},

		OpenFrames = {},

		BlockWindowDrag = false,

		WindowOpenState = false,
		InputBlockAction = "SOLIX_UI_INPUT_BLOCK",
		InputBlockGui = nil,
		InputBlocker = nil,
		DisplayOrders = {
			Holder = 2,
			OtherHolder = 2,
			FloatingButton = 3,
			InputBlock = 9998,
			HolderOpen = 9999,
			FloatingButtonOpen = 10000,
			Cursor = 10001,
		},
		MouseStateBeforeOpen = nil,
		CursorGui = nil,
		MouseCursor = nil,
		MouseCursorImage = "rbxasset://textures/Cursors/KeyboardMouse/ArrowFarCursor.png",
		MouseCursorImageFallback = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png",
		MouseCursorSize = 64,
		MouseCursorHotspot = Vector2New(31, 32),
		SafeMode = false,
		UILoading = false,
		LoadingConfig = false,
		KeybindEntries = {},
		BackgroundEffects = nil,
		ExternalGuiStates = {},
		BackgroundDarkenEnabled = true,
		BackgroundEffect = "Snow",
		BackgroundEffectOptions = {"None", "Snow", "Rain"},
		ShowWatermark = false,
		ShowKeybindList = false,
		ShowMenuButton = true,
		AutoExecute = false,
		LanguagePreset = "Auto",
		LanguageOptions = { "Auto", "English", "Chinese", "Korean", "Spanish", "Russian" },
		LanguageToCode = {
			["Auto"] = "auto",
			["English"] = "en",
			["Chinese"] = "zh",
			["Korean"] = "ko",
			["Spanish"] = "es",
			["Russian"] = "ru",
		},
		MenuScalePreset = "Medium",
		MenuTweenStyle = "Cubic",
		MenuTweenDirection = "Out",
		MainWindowFrame = nil,

		Fonts = {
			["Inter"] = {
				Id = "InterSemibold.ttf",
				Url = "https://raw.githubusercontent.com/sametexe001/luas/main/fonts/InterSemibold.ttf",
				Weight = 200,
				Style = "normal",
				TextMultiplier = 1,
			},
			["Tahoma"] = {
				Id = "Tahoma.ttf",
				Url = "https://github.com/LuckyHub1/LuckyHub/raw/main/zekton_rg.ttf",
				Weight = 200,
				Style = "normal",
				TextMultiplier = 1.2,
			},
			["Minecraftia"] = {
				Id = "Minecraftia.ttf",
				Url = "https://github.com/LuckyHub1/LuckyHub/raw/refs/heads/main/Minecraftia.ttf",
				Weight = 200,
				Style = "normal",
				TextMultiplier = 1,
			},
			["Silkscreen"] = {
				Id = "Silkscreen.ttf",
				Url = "https://github.com/LuckyHub1/LuckyHub/raw/refs/heads/main/Silkscreen.ttf",
				Weight = 200,
				Style = "normal",
				TextMultiplier = 1,
			},
			["ProggyClean"] = {
				Id = "ProggyClean.ttf",
				Url = "https://github.com/LuckyHub1/LuckyHub/raw/main/ProggyClean.ttf",
				Weight = 200,
				Style = "normal",
				TextMultiplier = 1,
			},
			["Made Bold"] = {
				Id = "MadeBold.otf",
				Url = "https://raw.githubusercontent.com/ccrrrr1/V3/main/Fonts/Made_Bold%20(1).otf",
				Weight = 200,
				Style = "normal",
				TextMultiplier = 1,
			},
		},

		FontFaces = {},

		FontSettings = {
			Name = "Inter",
			TextSize = 14,
			SmallTextSize = 12,
			TitleTextSize = 20,
		},

		SliderElements = {},
		TextboxElements = {},
		SectionElements = {},

		HideOnOverlap = function(self, IsOpen, OptionHolder)
			if not IsOpen then
				for _, TextboxData in Library.TextboxElements do
					TextboxData.Input.Instance.TextTransparency = 0
				end
				return
			end

			if not OptionHolder or not OptionHolder.Parent then return end

			local DropTop = OptionHolder.AbsolutePosition.Y
			local DropBottom = DropTop + OptionHolder.AbsoluteSize.Y

			for _, TextboxData in Library.TextboxElements do
				local TextboxTop = TextboxData.Background.Instance.AbsolutePosition.Y
				local TextboxBottom = TextboxTop + TextboxData.Background.Instance.AbsoluteSize.Y

				if TextboxBottom > DropTop and TextboxTop < DropBottom then
					TextboxData.Input.Instance.TextTransparency = 1
				else
					TextboxData.Input.Instance.TextTransparency = 0
				end
			end
		end,

		SetFlags = {},
		ConfigFlagCallbacks = {},
		ConfigLoadedCallbacks = {},
		Themes = {},

		UnnamedConnections = 0,

		ScriptConfigFlags = {},
		SettingsConfigFlags = {
			["FloatingButtonPosition"] = true,
			["Auto Save Config"] = true,
			["Safe Mode"] = true,
			["Autoloads the selected configuration on next load"] = true,
			["Autoload Theme On Execute"] = true,
			["Background Snow"] = true,
			["Background Effect"] = true,
			["Show Watermark"] = true,
			["Show Menu Button"] = true,
			["Show Floating Button"] = true,
			["Show Keybind List"] = true,
			["Background Darken"] = true,
			["Auto Execute"] = true,
			["UI Font"] = true,
			["Theme Name"] = true,
			["Config Name"] = true,
			["Pasted Config"] = true,
			["Menu Keybind"] = true,
		},

		Holder = nil,
		NotifHolder = nil,
		UnusedHolder = nil,

		Font = nil
	}

	Library.__index = Library
	Library.Sections.__index = Library.Sections
	Library.Pages.__index = Library.Pages

	Library["Folders"] = Folder_Configs
	Library.Folders_Path = Folder_Configs

	Library.Localization = Localization

	Library.Translate = function(Text, Context)
		return Localization:Translate(Text, Context)
	end

	Library.FormatByKey = function(Key, Arguments)
		return Localization:FormatByKey(Key, Arguments)
	end

	Library.SetLanguage = function(LocaleCode)
		return Localization:SetLanguage(LocaleCode)
	end

	Library.GetLanguage = function()
		return Localization:GetLanguage()
	end

	Library.ApplyLanguagePreset = function(self, PresetName)
		if type(PresetName) ~= "string" or PresetName == "" then
			PresetName = "Auto"
		end

		self.LanguagePreset = PresetName

		local LocaleCode = self.LanguageToCode[PresetName] or "auto"
		Localization:ReloadRemoteTranslations()
		Localization:SetLanguage(LocaleCode)

		task.defer(function()
			if Library and Library.Localization then
				Library.Localization:RefreshAll()
			end
		end)

		return true
	end

	Library.LoadTranslations = function(Url)
		return Localization:ReloadRemoteTranslations(Url)
	end

	local Keys = {
		["Unknown"]           = "Unknown",
		["Backspace"]         = "Back",
		["Tab"]               = "Tab",
		["Clear"]             = "Clear",
		["Return"]            = "Return",
		["Pause"]             = "Pause",
		["Escape"]            = "Escape",
		["Space"]             = "Space",
		["QuotedDouble"]      = '"',
		["Hash"]              = "#",
		["Dollar"]            = "$",
		["Percent"]           = "%",
		["Ampersand"]         = "&",
		["Quote"]             = "'",
		["LeftParenthesis"]   = "(",
		["RightParenthesis"]  = " )",
		["Asterisk"]          = "*",
		["Plus"]              = "+",
		["Comma"]             = ",",
		["Minus"]             = "-",
		["Period"]            = ".",
		["Slash"]             = "`",
		["Three"]             = "3",
		["Seven"]             = "7",
		["Eight"]             = "8",
		["Colon"]             = ":",
		["Semicolon"]         = ";",
		["LessThan"]          = "<",
		["GreaterThan"]       = ">",
		["Question"]          = "?",
		["Equals"]            = "=",
		["At"]                = "@",
		["LeftBracket"]       = "LeftBracket",
		["RightBracket"]      = "RightBracked",
		["BackSlash"]         = "BackSlash",
		["Caret"]             = "^",
		["Underscore"]        = "_",
		["Backquote"]         = "`",
		["LeftCurly"]         = "{",
		["Pipe"]              = "|",
		["RightCurly"]        = "}",
		["Tilde"]             = "~",
		["Delete"]            = "Delete",
		["End"]               = "End",
		["KeypadZero"]        = "Keypad0",
		["KeypadOne"]         = "Keypad1",
		["KeypadTwo"]         = "Keypad2",
		["KeypadThree"]       = "Keypad3",
		["KeypadFour"]        = "Keypad4",
		["KeypadFive"]        = "Keypad5",
		["KeypadSix"]         = "Keypad6",
		["KeypadSeven"]       = "Keypad7",
		["KeypadEight"]       = "Keypad8",
		["KeypadNine"]        = "Keypad9",
		["KeypadPeriod"]      = "KeypadP",
		["KeypadDivide"]      = "KeypadD",
		["KeypadMultiply"]    = "KeypadM",
		["KeypadMinus"]       = "KeypadM",
		["KeypadPlus"]        = "KeypadP",
		["KeypadEnter"]       = "KeypadE",
		["KeypadEquals"]      = "KeypadE",
		["Insert"]            = "Insert",
		["Home"]              = "Home",
		["PageUp"]            = "PageUp",
		["PageDown"]          = "PageDown",
		["RightShift"]        = "RightShift",
		["LeftShift"]         = "LeftShift",
		["RightControl"]      = "RightControl",
		["LeftControl"]       = "LeftControl",
		["LeftAlt"]           = "LeftAlt",
		["RightAlt"]          = "RightAlt"
	}

	local KEYBIND_NONE_KEY = Enum.KeyCode.Backspace

	local function is_keybind_none_key(key)
		if key == nil then
			return true
		end

		if key == "None" or key == "Backspace" then
			return true
		end

		if typeof(key) == "EnumItem" then
			return key == KEYBIND_NONE_KEY
		end

		local key_string = tostring(key)
		return key_string == "Enum.KeyCode.Backspace" or key_string == "Backspace"
	end

	local function get_keybind_display_text(bound_key, stored_key)
		if is_keybind_none_key(bound_key) or is_keybind_none_key(stored_key) then
			return "None"
		end

		local key_string = Keys[stored_key] or StringGSub(tostring(bound_key), "Enum.", "") or "None"
		return StringGSub(StringGSub(key_string, "KeyCode.", ""), "UserInputType.", "") or "None"
	end

	local Themes = {
		["Solix"] = {
			["Background"] = FromRGB(14, 13, 18),
			["Inline"] = FromRGB(22, 21, 28),
			["Border"] = FromRGB(42, 40, 52),
			["Shadow"] = FromRGB(8, 6, 12),
			["Text"] = FromRGB(242, 240, 248),
			["Inactive Text"] = FromRGB(148, 144, 162),
			["Accent"] = FromRGB(196, 152, 255),
			["Element"] = FromRGB(32, 30, 40),
			["Gradient"] = FromRGB(210, 200, 230),
		},

		["Fatality"] = {
			["Background"] = FromRGB(16, 16, 18),
			["Inline"] = FromRGB(24, 24, 28),
			["Border"] = FromRGB(46, 46, 52),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(245, 245, 245),
			["Inactive Text"] = FromRGB(135, 135, 145),
			["Accent"] = FromRGB(255, 75, 125),
			["Element"] = FromRGB(30, 30, 34),
			["Gradient"] = FromRGB(255, 170, 210),
		},
		
		["Primordial"] = {
			["Background"] = FromRGB(10, 12, 16),
			["Inline"] = FromRGB(18, 22, 30),
			["Border"] = FromRGB(36, 44, 58),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(240, 245, 255),
			["Inactive Text"] = FromRGB(125, 140, 165),
			["Accent"] = FromRGB(90, 140, 255),
			["Element"] = FromRGB(24, 28, 38),
			["Gradient"] = FromRGB(180, 205, 255),
		},
		
		["Pandora"] = {
			["Background"] = FromRGB(14, 10, 20),
			["Inline"] = FromRGB(24, 18, 34),
			["Border"] = FromRGB(44, 34, 64),
			["Shadow"] = FromRGB(20, 0, 40),
			["Text"] = FromRGB(248, 242, 255),
			["Inactive Text"] = FromRGB(150, 140, 180),
			["Accent"] = FromRGB(170, 85, 255),
			["Element"] = FromRGB(28, 22, 40),
			["Gradient"] = FromRGB(215, 180, 255),
		},
		
		["Skeet"] = {
			["Background"] = FromRGB(17, 19, 14),
			["Inline"] = FromRGB(24, 28, 20),
			["Border"] = FromRGB(42, 48, 36),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(242, 245, 238),
			["Inactive Text"] = FromRGB(145, 152, 132),
			["Accent"] = FromRGB(170, 255, 85),
			["Element"] = FromRGB(30, 34, 26),
			["Gradient"] = FromRGB(200, 225, 170),
		},
		
		["Rifk"] = {
			["Background"] = FromRGB(10, 10, 12),
			["Inline"] = FromRGB(18, 18, 22),
			["Border"] = FromRGB(36, 36, 42),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(245, 245, 248),
			["Inactive Text"] = FromRGB(125, 125, 135),
			["Accent"] = FromRGB(255, 255, 255),
			["Element"] = FromRGB(24, 24, 28),
			["Gradient"] = FromRGB(185, 185, 190),
		},
		
		
	}

	Library.Theme = TableClone(Themes["Solix"])
	Library.Themes = Themes

	local LibFolders = GetFolders()

	for Index, Value in LibFolders do 
		if not isfolder(Value) then
			makefolder(Value)
		end
	end

	local Tween = {} do
		Tween.__index = Tween

		Tween.Create = function(self, Item, Info, Goal, IsRawItem)
			if not Library then
				return
			end

			Item = IsRawItem and Item or Item.Instance
			Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

			if Library:ShouldSkipVisualTween() and type(Goal) == "table" then
				Library:ApplyTweenGoals(Item, Goal)

				return {
					Tween = nil,
					Info = Info,
					Goal = Goal,
					Item = Item,
				}
			end

			local NewTween = {
				Tween = TweenService:Create(Item, Info, Goal),
				Info = Info,
				Goal = Goal,
				Item = Item
			}

			NewTween.Tween:Play()

			setmetatable(NewTween, Tween)

			return NewTween
		end

		Tween.GetProperty = function(self, Item)
			local className = Item.ClassName

			if className == "Frame" then
				return { "BackgroundTransparency" }
			elseif className == "TextLabel" or className == "TextButton" then
				return { "TextTransparency", "BackgroundTransparency" }
			elseif className == "ImageLabel" or className == "ImageButton" then
				return { "BackgroundTransparency", "ImageTransparency" }
			elseif className == "ScrollingFrame" then
				return { "BackgroundTransparency", "ScrollBarImageTransparency" }
			elseif className == "TextBox" then
				return { "TextTransparency", "BackgroundTransparency" }
			elseif className == "UIStroke" then
				return { "Transparency" }
			end
		end

		Tween.FadeItem = function(self, Item, Property, Visibility, Speed)
			local Item = Item or self.Item 
			local OldTransparency = Item[Property]

			if Library:ShouldSkipVisualTween() then
				Item[Property] = Visibility and OldTransparency or 1

				return {
					Tween = nil,
					Goal = {
						[Property] = Visibility and OldTransparency or 1,
					},
					Item = Item,
				}
			end

			Item[Property] = Visibility and 1 or OldTransparency

			local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
				[Property] = Visibility and OldTransparency or 1
			}, true)

			if NewTween and NewTween.Tween then
				Library:Connect(NewTween.Tween.Completed, function()
					if not Visibility then
						wait()
						Item[Property] = OldTransparency
					end
				end)
			end

			return NewTween
		end

		Tween.Get = function(self)
			if not self.Tween then 
				return
			end

			return self.Tween, self.Info, self.Goal
		end

		Tween.Pause = function(self)
			if not self.Tween then 
				return
			end

			self.Tween:Pause()
		end

		Tween.Play = function(self)
			if not self.Tween then 
				return
			end

			self.Tween:Play()
		end

		Tween.Clean = function(self)
			if not self.Tween then
				return
			end

			self.Tween:Pause()
			self = nil
		end
	end

	local Instances = {} do
		Instances.__index = Instances

		Instances.Create = function(self, Class, Properties)
			local Success, Result = pcall(function()
				local NewItem = {
					Instance = InstanceNew(Class),
					Properties = Properties,
					Class = Class
				}

				setmetatable(NewItem, Instances)

				for Property, Value in pairs(NewItem.Properties) do
					local PropSuccess = pcall(function()
						NewItem.Instance[Property] = Value
					end)
				end

				if Class == "TextLabel" or Class == "TextButton" or Class == "TextBox" then
					pcall(function()
						NewItem.Instance.AutoLocalize = false
					end)

					local TextSize = NewItem.Instance.TextSize

					if TextSize and TextSize > 0 then
						if TextSize <= 12 then
							NewItem.Instance:SetAttribute("SolixUIFontBucket", "Small")
						elseif TextSize >= 18 then
							NewItem.Instance:SetAttribute("SolixUIFontBucket", "Title")
						else
							NewItem.Instance:SetAttribute("SolixUIFontBucket", "Main")
						end
					end

					local TextInstance = NewItem.Instance

					if Class == "TextBox" then
						Localization:HookTextInstance(TextInstance, {"PlaceholderText"})

						if TextInstance.PlaceholderText ~= "" then
							Localization:ApplyText(TextInstance, TextInstance.PlaceholderText, "PlaceholderText")
						end
					else
						Localization:HookTextInstance(TextInstance, {"Text"})

						if TextInstance.Text ~= "" then
							Localization:ApplyText(TextInstance, TextInstance.Text, "Text")
						end
					end
				end

				return NewItem
			end)

			if Success and Result then
				return Result
			end

			return {
				Instance = nil,
				Properties = Properties or {},
				Class = Class,
				_Protected = true
			}
		end

		Instances.AddToTheme = function(self, Properties)
			if not self.Instance then 
				return
			end

			Library:AddToTheme(self, Properties)

			return self
		end

		Instances.ChangeItemTheme = function(self, Properties)
			if not self.Instance then 
				return
			end

			Library:ChangeItemTheme(self, Properties)
		end

		Instances.Connect = function(self, Event, Callback, Name)
			if not self.Instance then 
				return
			end

			if not self.Instance[Event] then 
				return
			end

			if IsMobile then
				if Event == "MouseButton1Down" or Event == "MouseButton1Click" then
					Event = "TouchTap"
				end
			end

			return Library:Connect(self.Instance[Event], Callback, Name)
		end

		Instances.Set = function(self, Property, Value)
			if not self.Instance then
				return
			end

			if Property == "Text" or Property == "PlaceholderText" then
				if self.Class == "TextBox" and Property == "Text" then
					self.Instance[Property] = Value
				else
					Localization:ApplyText(self.Instance, Value, Property)
				end
			else
				self.Instance[Property] = Value
			end

			return self
		end

		Instances.Tween = function(self, Info, Goal)
			if not self.Instance then
				return
			end

			if not Library then
				return
			end

			if Library:ShouldSkipVisualTween() and type(Goal) == "table" then
				Library:ApplyTweenGoals(self.Instance, Goal)
				return
			end

			return Tween:Create(self, Info, Goal)
		end

		Instances.Disconnect = function(self, Name)
			if not self.Instance then 
				return
			end

			return Library:Disconnect(Name)
		end

		Instances.Clean = function(self)
			if not self.Instance then 
				return
			end

			self.Instance:Destroy()
			self = nil
		end

		local function GetInputGuiTarget(Input)
			local Ok, Target = pcall(function()
				return Input.Target
			end)

			if Ok and typeof(Target) == "Instance" then
				return Target
			end

			local Ok2, GuiObjects = pcall(function()
				return UserInputService:GetGuiObjectsAtPosition(Input.Position.X, Input.Position.Y)
			end)

			if Ok2 and GuiObjects and #GuiObjects > 0 then
				return GuiObjects[1]
			end

			return nil
		end

		local function ShouldBlockWindowDrag(Target)
			if not Target then
				return false
			end

			local Current = Target

			while Current do
				if Current:IsA("ViewportFrame") then
					return true
				end

				if Current:GetAttribute("BlockWindowDrag") == true then
					return true
				end

				Current = Current.Parent
			end

			return false
		end

		Instances.MakeDraggable = function(self)
			if not self.Instance then 
				return
			end

			local Gui = self.Instance

			local Dragging = false 
			local DragStart
			local StartPosition
			local MoveConnection
			local EndConnection

			local function DisconnectDragConnection(Connection)
				if Connection then
					pcall(function()
						Connection:Disconnect()
					end)
				end
			end

			local function StopDrag()
				Dragging = false
				DragStart = nil
				StartPosition = nil

				DisconnectDragConnection(MoveConnection)
				MoveConnection = nil

				DisconnectDragConnection(EndConnection)
				EndConnection = nil
			end

			self:Connect("InputBegan", function(Input)
				if Library.BlockWindowDrag or ShouldBlockWindowDrag(GetInputGuiTarget(Input)) then
					return
				end

				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					StopDrag()

					NormalizeDragPosition(Gui)

					Dragging = true
					DragStart = GetMouseLocation()
					StartPosition = Gui.Position

					MoveConnection = UserInputService.InputChanged:Connect(function(MoveInput)
						if not Dragging or not DragStart or not StartPosition then
							return
						end

						if Library.BlockWindowDrag then
							StopDrag()
							return
						end

						if MoveInput.UserInputType ~= Enum.UserInputType.MouseMovement and MoveInput.UserInputType ~= Enum.UserInputType.Touch then
							return
						end

						local Scale = GetDragScale(Gui)
						local Mouse = GetMouseLocation()
						local DragDelta = (Mouse - DragStart) / Scale

						Gui.Position = UDim2New(
							StartPosition.X.Scale,
							StartPosition.X.Offset + DragDelta.X,
							StartPosition.Y.Scale,
							StartPosition.Y.Offset + DragDelta.Y
						)
					end)

					EndConnection = UserInputService.InputEnded:Connect(function(EndInput)
						if not Dragging then
							return
						end

						if EndInput.UserInputType == Enum.UserInputType.MouseButton1 or EndInput.UserInputType == Enum.UserInputType.Touch then
							StopDrag()
						end
					end)
				end
			end)

			return Dragging
		end

		Instances.MakeResizeable = function(self, Minimum)
			if not self.Instance then 
				return
			end

			local Gui = self.Instance

			local Resizing = false 
			local CurrentSide = nil

			local StartMouse = nil
			local StartPosition = nil
			local StartSize = nil

			local EdgeThickness = 6
			local CornerSize = 14

			local MakeEdge = function(Name, Position, Size)
				local Button = Instances:Create("TextButton", {
					Parent = Gui,
					Name = "\0",
					Size = Size,
					Position = Position,
					BackgroundColor3 = FromRGB(166, 147, 243),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = "",
					AutoButtonColor = false,
					ZIndex = 99999
				})  Button:AddToTheme({BackgroundColor3 = "Accent"})

				return Button
			end

			local Edges = {
				{Button = MakeEdge(
					"Left", 
					UDim2New(0, 0, 0, 0), 
					UDim2New(0, EdgeThickness, 1, 0)), 
					Side = "L"
				},

				{Button = MakeEdge(
					"Right", 
					UDim2New(1, -EdgeThickness, 0, 0), 
					UDim2New(0, EdgeThickness, 1, 0)), 
					Side = "R"
				},

				{Button = MakeEdge(
					"Top", UDim2New(0, 0, 0, 0), 
					UDim2New(1, 0, 0, EdgeThickness)), 
					Side = "T"
				},

				{Button = MakeEdge(
					"Bottom", 
					UDim2New(0, 0, 1, -EdgeThickness), 
					UDim2New(1, 0, 0, EdgeThickness)),
					Side = "B"
				},

				{Button = MakeEdge(
					"TopLeft",
					UDim2New(0, 0, 0, 0),
					UDim2New(0, CornerSize, 0, CornerSize)),
					Side = "TL"
				},

				{Button = MakeEdge(
					"TopRight",
					UDim2New(1, -CornerSize, 0, 0),
					UDim2New(0, CornerSize, 0, CornerSize)),
					Side = "TR"
				},

				{Button = MakeEdge(
					"BottomLeft",
					UDim2New(0, 0, 1, -CornerSize),
					UDim2New(0, CornerSize, 0, CornerSize)),
					Side = "BL"
				},

				{Button = MakeEdge(
					"BottomRight",
					UDim2New(1, -CornerSize, 1, -CornerSize),
					UDim2New(0, CornerSize, 0, CornerSize)),
					Side = "BR"
				},
			}

			local BeginResizing = function(Side)
				NormalizeDragPosition(Gui)

				Resizing = true
				CurrentSide = Side

				StartMouse = GetMouseLocation()

				StartPosition = Vector2New(Gui.Position.X.Offset, Gui.Position.Y.Offset)
				StartSize = Vector2New(Gui.Size.X.Offset, Gui.Size.Y.Offset)

				for _, Edge in Edges do
					Edge.Button.Instance.BackgroundTransparency = Edge.Side == Side and 0 or 1
				end
			end

			local EndResizing = function()
				Resizing = false
				CurrentSide = nil

				for _, Edge in Edges do
					Edge.Button.Instance.BackgroundTransparency = 1
				end
			end

			for _, Edge in Edges do
				local Side = Edge.Side
				Edge.Button:Connect("InputBegan", function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						BeginResizing(Side)
					end
				end)
			end

			Library:Connect(UserInputService.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if Resizing then
						EndResizing()
					end
				end
			end)

			Library:Connect(RunService.RenderStepped, function()
				if not Resizing or not CurrentSide then
					return
				end

				local Scale = Library.UIScaleNum or 1
				local MouseLocation = GetMouseLocation()
				local MouseX = (MouseLocation.X - StartMouse.X) / Scale
				local MouseY = (MouseLocation.Y - StartMouse.Y) / Scale

				local PostionX, PostionY = StartPosition.X, StartPosition.Y
				local SizeX, SizeY = StartSize.X, StartSize.Y

				if CurrentSide == "L" or CurrentSide == "TL" or CurrentSide == "BL" then
					PostionX = StartPosition.X + MouseX
					SizeX = StartSize.X - MouseX
				elseif CurrentSide == "R" or CurrentSide == "TR" or CurrentSide == "BR" then
					SizeX = StartSize.X + MouseX
				end

				if CurrentSide == "T" or CurrentSide == "TL" or CurrentSide == "TR" then
					PostionY = StartPosition.Y + MouseY
					SizeY = StartSize.Y - MouseY
				elseif CurrentSide == "B" or CurrentSide == "BL" or CurrentSide == "BR" then
					SizeY = StartSize.Y + MouseY
				end

				if SizeX < Minimum.X then
					if CurrentSide == "L" or CurrentSide == "TL" or CurrentSide == "BL" then
						PostionX = PostionX - (Minimum.X - SizeX)
					end
					SizeX = Minimum.X
				end

				if SizeY < Minimum.Y then
					if CurrentSide == "T" or CurrentSide == "TL" or CurrentSide == "TR" then
						PostionY = PostionY - (Minimum.Y - SizeY)
					end
					SizeY = Minimum.Y
				end

				self:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2FromOffset(PostionX, PostionY)})
				self:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2FromOffset(SizeX, SizeY)})
			end)
		end

		Instances.OnHover = function(self, Function)
			if not self.Instance then 
				return
			end

			return Library:Connect(self.Instance.MouseEnter, Function)
		end

		Instances.OnHoverLeave = function(self, Function)
			if not self.Instance then 
				return
			end

			return Library:Connect(self.Instance.MouseLeave, Function)
		end

		Instances.Tooltip = function(self, Text)
			if not self.Instance then 
				return
			end

			if Text == nil or Text == "" then 
				return
			end

			local Gui = self.Instance

			local MouseLocation = GetMouseLocation()
			local RenderStepped
			local Scale = Library.UIScaleNum or 1

			local Items = {} do
				Items["Tooltip"] = Instances:Create("Frame", {
					Parent = Library.Holder.Instance,
					Name = "\0",
					Size = UDim2New(0, 0, 0, 0),
					Position = UDim2New(0, MouseLocation.X / Scale, 0, (MouseLocation.Y - 22) / Scale),
					BackgroundColor3 = Library.Theme["Background"],
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					ZIndex = 99,
					Visible = true
				}):AddToTheme({BackgroundColor3 = 'Background'})

				Items["Text"] = Instances:Create("TextLabel", {
					Parent = Items["Tooltip"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 1, 0),
					BackgroundColor3 = FromRGB(15, 12, 16),
					BackgroundTransparency = 1,
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Text = Text,
					TextColor3 = Library.Theme["Text"],
					TextSize = 14,
					FontFace = Library.Font,
					TextTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					ClipsDescendants = true,
					AutomaticSize = Enum.AutomaticSize.XY,
					ZIndex = 99
				}):AddToTheme({TextColor3 = 'Text'})

				Instances:Create("UIPadding", {
					Parent = Items["Text"].Instance,
					Name = "\0",
					PaddingLeft = UDimNew(0, 8),
					PaddingRight = UDimNew(0, 8),
					PaddingTop = UDimNew(0, 8),
					PaddingBottom = UDimNew(0, 8)
				})

				Instances:Create("UICorner", {
					Parent = Items["Tooltip"].Instance,
					Name = "\0",
					CornerRadius = UDimNew(0, 5)
				})
			end

			Library:Connect(Gui.MouseEnter, function()
				Items["Tooltip"].Instance.Position = UDim2New(0, MouseLocation.X / Scale, 0, (MouseLocation.Y - 42) / Scale)
				Items["Tooltip"]:Tween(nil, {BackgroundTransparency = 0})
				Items["Text"]:Tween(nil, {TextTransparency = 0})

				RenderStepped = RunService.RenderStepped:Connect(function()
					MouseLocation = GetMouseLocation()

					local Scale = Library.UIScaleNum or 1

					Items["Tooltip"]:Tween(nil, {Position = UDim2New(0, MouseLocation.X / Scale, 0, (MouseLocation.Y - 42) / Scale)})
				end)
			end)

			Library:Connect(Gui.MouseLeave, function()
				Items["Tooltip"]:Tween(nil, {BackgroundTransparency = 1})
				Items["Text"]:Tween(nil, {TextTransparency = 1})

				if RenderStepped then 
					RenderStepped:Disconnect()
					RenderStepped = nil
				end
			end)
		end
	end

	local FontsFolder = GetFolders().Assets .. "/fonts"

	local function RegisterFont(Name, Weight, Style, TtfFile, Url)
		local TtfPath = FontsFolder .. "/" .. TtfFile

		if not isfile(TtfPath) then
			writefile(TtfPath, game:HttpGet(Url))
		end

		local FontMetaPath = FontsFolder .. "/" .. Name .. ".font"

		if isfile(FontMetaPath) then
			delfile(FontMetaPath)
		end

		local AssetSuccess, AssetId = pcall(getcustomasset, TtfPath)

		if not AssetSuccess then
			return nil
		end

		local FontData = {
			name = Name,
			faces = {
				{
					name = "Regular",
					weight = Weight,
					style = Style,
					assetId = AssetId,
				},
			},
		}

		writefile(FontMetaPath, HttpService:JSONEncode(FontData))

		local FontAssetSuccess, FontAssetId = pcall(getcustomasset, FontMetaPath)

		if not FontAssetSuccess then
			return nil
		end

		return FontAssetId
	end

	do
		for Name, Data in Library.Fonts do
			local Success, AssetPath = pcall(function()
				return RegisterFont(Name, Data.Weight or 200, Data.Style or "normal", Data.Id, Data.Url)
			end)

			if Success and AssetPath then
				local FaceSuccess, Face = pcall(function()
					return Font.new(AssetPath, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				end)

				if FaceSuccess and Face then
					Library.FontFaces[Name] = Face
				end
			end
		end

		Library.Font = Library.FontFaces[Library.FontSettings.Name] or Font.fromEnum(Enum.Font.Gotham)
	end

	Library.GetFontNames = function(self)
		local Names = {}

		for Name in self.Fonts do
			TableInsert(Names, Name)
		end

		table.sort(Names)

		return Names
	end

	Library.GetFontTextMultiplier = function(self)
		local FontData = self.Fonts[self.FontSettings.Name]

		return (FontData and FontData.TextMultiplier) or 1
	end

	Library.GetTextSizeForBucket = function(self, Bucket)
		if Bucket == "Small" then
			return self.FontSettings.SmallTextSize
		elseif Bucket == "Title" then
			return self.FontSettings.TitleTextSize
		end

		return self.FontSettings.TextSize
	end

	Library.ApplyFontSettings = function(self)
		local Roots = {}

		if self.Holder and self.Holder.Instance then
			TableInsert(Roots, self.Holder.Instance)
		end

		if self.OtherHolder and self.OtherHolder.Instance then
			TableInsert(Roots, self.OtherHolder.Instance)
		end

		if self.FloatingButtonHolder and self.FloatingButtonHolder.Instance then
			TableInsert(Roots, self.FloatingButtonHolder.Instance)
		end

		if self.UnusedHolder and self.UnusedHolder.Instance then
			TableInsert(Roots, self.UnusedHolder.Instance)
		end

		if self.NotifHolder and self.NotifHolder.Instance then
			TableInsert(Roots, self.NotifHolder.Instance)
		end

		if self.WatermarkGui and self.WatermarkGui.Instance then
			TableInsert(Roots, self.WatermarkGui.Instance)
		end

		if #Roots == 0 then
			return
		end

		local Multiplier = self:GetFontTextMultiplier()

		for _, Root in Roots do
			for _, Instance in Root:GetDescendants() do
				if Instance:IsA("TextLabel") or Instance:IsA("TextButton") or Instance:IsA("TextBox") then
					pcall(function()
						local Bucket = Instance:GetAttribute("SolixUIFontBucket") or "Main"
						local BaseSize = self:GetTextSizeForBucket(Bucket)

						Instance.FontFace = self.Font
						Instance.TextSize = MathMax(1, MathFloor(BaseSize * Multiplier))
					end)
				end
			end
		end
	end

	Library.SetFont = function(self, FontName, SkipSave)
		local Face = self.FontFaces[FontName]

		if not Face then
			return false
		end

		self.Font = Face
		self.FontSettings.Name = FontName
		self:ApplyFontSettings()

		if not SkipSave and not self.LoadingConfig then
			self:SaveLocalSettings()
		end

		return true
	end

	Library.SetTextSizes = function(self, Main, Small, Title, SkipSave)
		if Main then
			self.FontSettings.TextSize = MathClamp(MathFloor(Main), 10, 20)
		end

		if Small then
			self.FontSettings.SmallTextSize = MathClamp(MathFloor(Small), 8, 16)
		end

		if Title then
			self.FontSettings.TitleTextSize = MathClamp(MathFloor(Title), 14, 28)
		end

		self:ApplyFontSettings()

		if not SkipSave and not self.LoadingConfig then
			self:SaveLocalSettings()
		end
	end

	Library.Holder = Instances:Create("ScreenGui", {
		Parent = SafeGetUI(),
		Name = "\0",
		DisplayOrder = Library.DisplayOrders.Holder,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
	})

	if not Library.Holder.Instance then
		local Success, Result = pcall(function()
			return Instance.new("ScreenGui")
		end)

		if Success then
			Library.Holder = {
				Instance = Result,
				Properties = {},
				Class = "ScreenGui"
			}

			Library.Holder.Instance.Parent = SafeGetUI()
			Library.Holder.Instance.Name = "\0"
			Library.Holder.Instance.ZIndexBehavior = Enum.ZIndexBehavior.Global
			Library.Holder.Instance.DisplayOrder = Library.DisplayOrders.Holder
			Library.Holder.Instance.IgnoreGuiInset = true
			Library.Holder.Instance.ResetOnSpawn = false
		end
	end

	wait()

	Library.InputBlockGui = Instances:Create("ScreenGui", {
		Parent = SafeGetUI(),
		Name = "\0",
		Enabled = false,
		DisplayOrder = Library.DisplayOrders.InputBlock,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
	})

	local ViewportSize = function()
		local Camera = Workspace.CurrentCamera

		return (Camera and Camera.ViewportSize) or Vector2New(1920, 1080)
	end

	Library.UIScaleDesignSize = Vector2New(770, 526)
	Library.UIScaleScreenPercent = 2.3 / 3
	Library.UIScaleObject = Instances:Create("UIScale", {
		Parent = Library.Holder.Instance,
		Name = "\0",
		Scale = 1
	})

	Library.UIScaleNum = 1

	function Library:SetScaleFromScreenPercent(Percent)
		Percent = MathClamp(Percent, 0.2, 1)

		self.UIScaleScreenPercent = Percent

		local DesignWidth, DesignHeight = self.UIScaleDesignSize.X, self.UIScaleDesignSize.Y
		local Scale

		if IsMobile then
			local Viewport = ViewportSize()

			Scale = Viewport.Y / 450
			Scale = Scale * Percent
			Scale = MathClamp(Scale, 0.8, 2.5)
		else
			local Viewport = ViewportSize()
			local TargetWidth = math.min(DesignWidth, Viewport.X * Percent)
			local TargetHeight = math.min(DesignHeight, Viewport.Y * Percent)

			local ScaleWidth = TargetWidth / DesignWidth
			local ScaleHeight = TargetHeight / DesignHeight

			Scale = math.min(ScaleWidth, ScaleHeight)
			Scale = MathClamp(Scale, 0.5, 1.2)
		end

		self.UIScaleObject.Instance.Scale = Scale
		self.UIScaleNum = Scale
	end

	function Library:SetScaleNumeric(Value)
		Value = MathClamp(Value, 300, 1400)

		self.UIScaleNumeric = Value
		self.UIScaleScreenPercent = Value / 1400

		local Viewport = ViewportSize()
		local Scale = Viewport.Y / Value
		Scale = MathClamp(Scale, 0.3, 3)

		self.UIScaleObject.Instance.Scale = Scale
		self.UIScaleNum = Scale
	end

	Library:SetScaleNumeric(1000)

	local ScaleValues = {
		["Very Small"] = 1200,
		["Small"] = 1100,
		["Medium"] = 1000,
		["Large"] = 800,
		["Bigger"] = 600,
		["Massive"] = 500,
	}

	defer(function()
		local Camera = Workspace.CurrentCamera

		if Camera then
			Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				if Library.UIScaleNumeric then
					Library:SetScaleNumeric(Library.UIScaleNumeric)
				end
			end)
		end
	end)

	Library.OtherHolder = Instances:Create("ScreenGui", {
		Parent = SafeGetUI(),
		Name = "\0",
		DisplayOrder = 2,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global
	})

	Library.FloatingButtonHolder = Instances:Create("ScreenGui", {
		Parent = SafeGetUI(),
		Name = "\0",
		DisplayOrder = 3,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global
	})

	Library.UnusedHolder = Instances:Create("ScreenGui", {
		Parent = SafeGetUI(),
		Name = "\0",
		Enabled = false,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global
	})

	wait()

	Library.InputBlocker = Instances:Create("TextButton", {
		Parent = Library.InputBlockGui.Instance,
		Name = "\0",
		Visible = false,
		Modal = true,
		AutoButtonColor = false,
		Active = true,
		Size = UDim2New(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		ZIndex = 2,
	})

	Library.CursorGui = Instances:Create("ScreenGui", {
		Parent = SafeGetUI(),
		Name = "\0",
		Enabled = false,
		DisplayOrder = Library.DisplayOrders.Cursor,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
	})

	Library.MouseCursor = Instances:Create("ImageLabel", {
		Parent = Library.CursorGui.Instance,
		Name = "\0",
		Visible = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		AnchorPoint = Vector2New(0, 0),
		Image = Library.MouseCursorImage,
		Size = UDim2FromOffset(Library.MouseCursorSize, Library.MouseCursorSize),
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 10001,
		Active = false,
	})

	task.defer(function()
		if not Library.MouseCursor or not Library.MouseCursor.Instance then
			return
		end

		if Library.MouseCursor.Instance.Image == "" and Library.MouseCursorImageFallback then
			Library.MouseCursor.Instance.Image = Library.MouseCursorImageFallback
		end
	end)

	Library.NotifHolder = Instances:Create("Frame", {
		Parent = Library.Holder.Instance,
		Name = "\0",
		Size = UDim2New(0, 0, 1, 0),
		Position = UDim2New(1, 0, 0, 0),
		AnchorPoint = Vector2New(1, 0),
		BackgroundTransparency = 1,
		BorderColor3 = FromRGB(0, 0, 0),
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.X
	})
	Library.NotifLayoutOrder = 0

	Instances:Create("UIListLayout", {
		Parent = Library.NotifHolder.Instance,
		Name = "\0",
		Padding = UDimNew(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Right
	})

	Instances:Create("UIPadding", {
		Parent = Library.NotifHolder.Instance,
		Name = "\0",
		PaddingLeft = UDimNew(0, 12),
		PaddingRight = UDimNew(0, 12),
		PaddingTop = UDimNew(0, 12),
		PaddingBottom = UDimNew(0, 12)
	})

	Library.GetDataFromPlayer = function(self, Section)
		local Player = Players.LocalPlayer

		Section:Label("Username: " .. Player.Name, "")
		Section:Label("UserId: " .. Player.UserId, "")
		Section:Label("Account Age: " .. Player.AccountAge, "")
		Section:Label("PlaceId: " .. (game.PlaceId or "N/A"), "")
	end

	Library.GetDataFromLuarmor = function(self, Section)
		local Labels = {}
		local KeyVars = {
			get = function(var)
				return getgenv()[var]
			end,

			current_key = getgenv().key
		}

		local WarningFrame = nil
		local ExpireThreshold = 550

		local ToTime do
			local UnitMultipliers = {
				{86400, "%dd %dh %dm %ds"},
				{3600, "%dh %dm %ds"},
				{60, "%dm %ds"},
				{1, "%ds"}
			}

			function ToTime(v)
				if not v then
					return "No Key"
				elseif v < 0 then
					return "Lifetime"
				end

				local Days = MathFloor(v / 86400)
				local Hours = MathFloor((v % 86400) / 3600)
				local Minutes = MathFloor((v % 3600) / 60)
				local Seconds = v % 60

				if Days > 0 then
					return StringFormat("%dd %dh %dm %ds", Days, Hours, Minutes, Seconds)
				elseif Hours > 0 then
					return StringFormat("%dh %dm %ds", Hours, Minutes, Seconds)
				elseif Minutes > 0 then
					return StringFormat("%dm %ds", Minutes, Seconds)
				else
					return StringFormat("%ds", Seconds)
				end
			end
		end

		local function UpdateKeyInfo()
			local Expire = KeyVars.get("key_expire")

			if Expire and Expire > 0 then
				local Remaining = Expire - os.time()

				if Remaining > 0 then
					Labels.Expires:SetText("Expires: " .. ToTime(Remaining))
				else
					Players.LocalPlayer:Kick("Your key has expired.")
				end
			else
				Labels.Expires:SetText("Expires: Lifetime")
			end

			Labels.Note:SetText("Note: " .. (KeyVars.get("key_note") or "None"))
			Labels.Executions:SetText("Executions: " .. tostring(KeyVars.get("key_executions") or 0))
		end

		local function ShowKeyWarning()
			if WarningFrame and WarningFrame.Instance then
				return
			end

			WarningFrame = Instances:Create("ImageLabel", {
				Parent = Library.Holder.Instance,
				Name = "\0",
				Size = UDim2New(0, 300, 0, 300),
				Position = UDim2New(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2New(0.5, 0.5),
				BackgroundColor3 = FromRGB(30, 30, 30),
				BorderSizePixel = 0,
				Image = "rbxassetid://75498856718303",
				ImageTransparency = 0,
				ZIndex = 9999
			})

			Instances:Create("UICorner", {
				Parent = WarningFrame.Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 8)
			})

			Instances:Create("TextLabel", {
				Parent = WarningFrame.Instance,
				Name = "\0",
				AnchorPoint = Vector2New(0.5, 0.5),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				FontFace = Library.Font,
				Position = UDim2New(0.5, 0, 0.55, 0),
				RichText = false,
				Size = UDim2New(1, -20, 0, 40),
				Text = "Your key is expiring soon ðŸ˜­ðŸ™",
				TextColor3 = Library.Theme["Text"],
				TextSize = 20,
				TextWrapped = true,
				ZIndex = 10000
			})
		end

		local function HideKeyWarning()
			if WarningFrame and WarningFrame.Instance then
				WarningFrame.Instance:Destroy()
				WarningFrame = nil
			end
		end

		local function RefreshKeyFromAPI()
			local Key = KeyVars.get("key")
			local Api = KeyVars.get("luarmor_api")

			if not Key or Key == "" or not Api then
				HideKeyWarning()
				return
			end

			local Success, Result = pcall(Api.check_key, Key)

			if Success and Result and Result.code == "KEY_VALID" then
				local Data = Result.data

				getgenv().key_expire = Data.auth_expire
				getgenv().key_note = Data.note
				getgenv().key_executions = Data.total_executions or 0

				UpdateKeyInfo()

				local Expire = Data.auth_expire

				if Expire and Expire > 0 then
					local Remaining = Expire - os.time()

					if Remaining > 0 and Remaining <= ExpireThreshold then
						ShowKeyWarning()
					elseif Remaining > ExpireThreshold then
						HideKeyWarning()
					end
				elseif Expire == 0 then
					HideKeyWarning()
				end
			end
		end

		local function InitLabels(v)
			if v then
				local Expire = KeyVars.get("key_expire")
				local Text = (Expire and Expire > 0) and ToTime(Expire - os.time()) or "Lifetime"

				Labels = {
					Status = Section:Label("Status: Active", ""),
					Expires = Section:Label("Expires: " .. Text, ""),
					Executions = Section:Label("Executions: " .. tostring(KeyVars.get("key_executions") or 0), ""),
					Note = Section:Label("Note: " .. (KeyVars.get("key_note") or "None"), "")
				}
			else
				Labels = {
					Status = Section:Label("Status: No Key", ""),
					Expires = Section:Label("Expires: Lifetime", ""),
					Executions = Section:Label("Executions: N/A", ""),
					Note = Section:Label("Note: N/A", "")
				}
			end
		end

		local HasKey = KeyVars.current_key and KeyVars.current_key ~= ""

		InitLabels(HasKey)

		Library:Thread(LPH_NO_VIRTUALIZE(function()
			while true do
				wait(1)
				pcall(UpdateKeyInfo)
			end
		end))

		Library:Thread(LPH_NO_VIRTUALIZE(function()
			while true do
				wait(30)
				pcall(RefreshKeyFromAPI)
			end
		end))
	end

	Library.Unload = function(self)
		if self.Localization then
			self.Localization:Clear()
		end

		for Index, Value in self.Connections do 
			Value.Connection:Disconnect()
		end

		for Index, Value in self.Threads do 
			coroutine.close(Value)
		end

		if self.Holder then 
			self.Holder:Clean()
		end

		if self.FloatingButtonHolder then
			self.FloatingButtonHolder.Instance:Destroy()
		end

		if self.WatermarkGui then
			self.WatermarkGui:Clean()
		end

		if self.BackgroundEffects then
			if self.BackgroundEffects.BlurEffect then
				pcall(function()
					self.BackgroundEffects.BlurEffect:Destroy()
				end)
			end

			self.BackgroundEffects = nil
		end

		if self.InputBlockGui and self.InputBlockGui.Instance then
			pcall(function()
				self.InputBlockGui.Instance:Destroy()
			end)
			self.InputBlockGui = nil
		end

		if self.CursorGui and self.CursorGui.Instance then
			pcall(function()
				self.CursorGui.Instance:Destroy()
			end)
			self.CursorGui = nil
		end

		self.MouseCursor = nil
		self.InputBlocker = nil
		self:ApplyWindowInputState(false)
		self:ApplyMouseForMenu(false)

		pcall(function()
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true
		end)

		Library = nil 
		getgenv().Library = nil
	end

	Library.Round = function(self, Number, Decimals)
		if not Decimals or Decimals <= 0 then
			return MathFloor(Number + 0.5)
		end

		local Multiplier = 10 ^ Decimals
		return MathFloor(Number * Multiplier + 0.5) / Multiplier
	end

	Library.Thread = function(self, Function)
		local NewThread = coroutine.create(Function)

		coroutine.wrap(function()
			coroutine.resume(NewThread)
		end)()

		TableInsert(self.Threads, NewThread)
		return NewThread
	end

	Library.SafeCall = function(self, Function, ...)
		local Arguements = { ... }
		local Success, Result = pcall(Function, TableUnpack(Arguements))

		if not Success then
			warn(Result)
			return false, Result
		end

		return true, Result
	end

	Library.ShouldFireElementCallback = function(self, Silent)
		if self.LoadingConfig == true then
			return false
		end

		if Silent == true then
			return false
		end

		if type(Silent) == "table" and (Silent.Silent == true or Silent.silent == true) then
			return false
		end

		if (self.SilentDepth or 0) > 0 then
			return false
		end

		return true
	end

	Library.ShouldSkipVisualTween = function(self)
		if self.UILoading == true then
			return true
		end

		if self.LoadingConfig == true then
			return true
		end

		if (self.SilentDepth or 0) > 0 then
			return true
		end

		return false
	end

	Library.BeginUILoading = function(self)
		self.UILoading = true
	end

	Library.EndUILoading = function(self)
		self.UILoading = false
	end

	Library.ApplyTweenGoals = function(self, InstanceObject, Goal)
		if not InstanceObject or type(Goal) ~= "table" then
			return
		end

		for Property, Value in Goal do
			pcall(function()
				InstanceObject[Property] = Value
			end)
		end
	end

	Library.BeginSilent = function(self)
		self.SilentDepth = (self.SilentDepth or 0) + 1
	end

	Library.EndSilent = function(self)
		self.SilentDepth = math.max(0, (self.SilentDepth or 0) - 1)
	end

	Library.ShouldSaveAutoload = function(self, Silent)
		if self.LoadingConfig == true then
			return false
		end

		if Silent == true then
			return false
		end

		if type(Silent) == "table" and (Silent.Silent == true or Silent.silent == true) then
			return false
		end

		if (self.SilentDepth or 0) > 0 then
			return false
		end

		return true
	end

	Library.OnConfigLoaded = function(self, Callback)
		if type(Callback) == "function" then
			TableInsert(self.ConfigLoadedCallbacks, Callback)
		end
	end

	Library.ApplyConfigEntry = function(self, Index, Value)
		if Index == "FloatingButtonPosition" then
			if Library.FloatingButton and Library.FloatingButton.Instance and type(Value) == "table" then
				local PositionX = Value.X
				local PositionY = Value.Y
				if type(PositionX) == "table" and type(PositionY) == "table" then
					Library.FloatingButton.Instance.Position = UDim2New(
						PositionX.Scale,
						PositionX.Offset,
						PositionY.Scale,
						PositionY.Offset
					)
				end
			end
			return true
		end

		if Index == "Auto Save Config" and type(Value) == "boolean" then
			Library.AutoSave = Value
			return true
		end

		if Index == "Safe Mode" and type(Value) == "boolean" then
			Library.SafeMode = Value
			Library:SaveLocalSettings()
			return true
		end

		if Index == "Autoloads the selected configuration on next load" and type(Value) == "boolean" then
			Library.AutoloadConfigEnabled = Value
			Library:SaveLocalSettings()
			return true
		end

		if Index == "Autoload Theme On Execute" and type(Value) == "boolean" then
			Library.AutoloadThemeEnabled = Value
			Library:SaveLocalSettings()
			return true
		end

		if Index == "Background Snow" and type(Value) == "boolean" then
			Library:SetBackgroundEffect(Value and "Snow" or "None")
			return true
		end

		if Index == "Background Effect" and type(Value) == "string" then
			Library:SetBackgroundEffect(Value)
			return true
		end

		if Index == "Show Watermark" and type(Value) == "boolean" then
			Library.ShowWatermark = Value
			Library:SaveLocalSettings()
			return true
		end

		if Index == "Show Menu Button" and type(Value) == "boolean" then
			Library.ShowMenuButton = Value
			Library:SaveLocalSettings()
			return true
		elseif Index == "Show Floating Button" and type(Value) == "boolean" then
			Library.ShowMenuButton = Value
			Library:SaveLocalSettings()
			return true
		end

		if Index == "Show Keybind List" and type(Value) == "boolean" then
			Library.ShowKeybindList = Value
			Library:SaveLocalSettings()
			return true
		end

		if Index == "Background Darken" and type(Value) == "boolean" then
			Library:SetBackgroundDarkenEnabled(Value)
			return true
		end

		if Index == "Auto Execute" and type(Value) == "boolean" then
			Library.AutoExecute = Value
			Library:SaveLocalSettings()
			return true
		end

		if Index == "UI Font" and type(Value) == "string" then
			Library:SetFont(Value)
			return true
		end

		local SetFunction = Library.SetFlags[Index]

		if not SetFunction then
			return true
		end

		if type(Value) == "table" and Value.Key then
			SetFunction(Value)
		elseif type(Value) == "table" and Value.Color then
			SetFunction(Value.Color, Value.Alpha)
		else
			SetFunction(Value)
		end

		return true
	end

	Library.Connect = function(self, Event, Callback, Name)
		Name = Name or StringFormat("connection_number_%s_%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))

		local NewConnection = {
			Event = Event,
			Callback = Callback,
			Name = Name,
			Connection = nil
		}

		Library:Thread(function()
			NewConnection.Connection = Event:Connect(Callback)
		end)

		TableInsert(self.Connections, NewConnection)
		return NewConnection
	end

	Library:Connect(RunService.RenderStepped, function()
		local MouseCursor = Library.MouseCursor

		if not MouseCursor or not MouseCursor.Instance or not Library.WindowOpenState then
			return
		end

		local MouseLocation = GetMouseLocation()
		local Hotspot = Library.MouseCursorHotspot

		MouseCursor.Instance.Position = UDim2FromOffset(
			MouseLocation.X - Hotspot.X,
			MouseLocation.Y - Hotspot.Y
		)
	end, "MouseCursor")

	Library.Disconnect = function(self, Name)
		for _, Connection in self.Connections do 
			if Connection.Name == Name then
				Connection.Connection:Disconnect()
				break
			end
		end
	end

	Library.RegisterConfigFlag = function(self, Flag)
		if type(Flag) ~= "string" or Flag == "" then
			return
		end

		self.ScriptConfigFlags[Flag] = true
	end

	Library.IsScriptConfigFlag = function(self, Flag)
		if type(Flag) ~= "string" or Flag == "" then
			return false
		end

		if self.SettingsConfigFlags[Flag] == true then
			return false
		end

		if StringFind(Flag, "ThemingThing", 1, true) then
			return false
		end

		return self.ScriptConfigFlags[Flag] == true
	end

	Library.ResolveElementFlag = function(self, Data)
		if type(Data) ~= "table" then
			return nil
		end

		local Flag = Data.Flag or Data.flag
		if type(Flag) ~= "string" or Flag == "" then
			return nil
		end

		return Flag
	end

	Library.BindElementFlag = function(self, Flag, Setter, Element)
		if type(Flag) ~= "string" or Flag == "" or type(Setter) ~= "function" then
			return
		end

		self:RegisterConfigFlag(Flag)
		self.SetFlags[Flag] = Setter

		if type(Element) == "table" and type(Element.Callback) == "function" then
			local element = Element
			self.ConfigFlagCallbacks[Flag] = function()
				if element.Disabled == true then
					return
				end
				self:SafeCall(element.Callback, element.Value)
			end
		end
	end

	Library.RegisterConfigFlagCallback = function(self, Flag, Callback)
		if type(Flag) ~= "string" or Flag == "" or type(Callback) ~= "function" then
			return
		end
		self.ConfigFlagCallbacks[Flag] = Callback
	end

	Library.FireConfigFlagCallbacks = function(self, Decoded)
		if type(Decoded) ~= "table" then
			return
		end
		for Index, _ in Decoded do
			if self:IsScriptConfigFlag(Index) ~= true then
				continue
			end
			local callback = self.ConfigFlagCallbacks[Index]
			if type(callback) == "function" then
				pcall(callback)
			end
		end
	end

	Library.IsLifetime = function(self)
		local Expire = getgenv().key_expire

		return Expire and Expire == -1
	end

	Library.CheckLifetime = function(self, Element, ElementType)
		if Element.Lifetime then
			if not self:IsLifetime() then
				if not self.UILoadded then
					return true
				end

				Element.ClickCount = (Element.ClickCount or 0) + 1

				self:Notification({
					Name = "Lifetime Required",
					Description = "This feature is only available for Solix Hub Lifetime users, Buy Lifetime key at https://solixhub.com",
					Color = Color3.fromRGB(255, 0, 0),
					Duration = 5
				})

				if Element.ClickCount >= 30 then
					if Element.SetDisabled then
						Element:SetDisabled(true)
					end
				end

				return false
			end
		end

		return true
	end

	Library.AddToTheme = function(self, Item, Properties)
		Item = Item.Instance or Item 

		local ThemeData = {
			Item = Item,
			Properties = Properties,
		}

		for Property, Value in ThemeData.Properties do
			if type(Value) == "string" then

				if not self.Theme[Value] then
					Item[Property] = Value 
				end

				Item[Property] = self.Theme[Value]
			else
				Item[Property] = Value()
			end
		end

		TableInsert(self.ThemeItems, ThemeData)
		self.ThemeMap[Item] = ThemeData
	end

	Library.ToRich = function(self, Text, Color)
		return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`
	end

	Library.GetConfig = function(self)
		local Config = {} 

		local Success, Result = Library:SafeCall(function()
			for Index, Value in Library.Flags do 
				if Library:IsScriptConfigFlag(Index) ~= true then
					continue
				end

				if type(Value) == "table" and Value.Key then
					Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
				elseif type(Value) == "table" and Value.Color then
					Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
				else
					Config[Index] = Value
				end
			end
		end)

		return HttpService:JSONEncode(Config)
	end

	Library.LoadConfig = function(self, Config)
		local DecodeSuccess, Decoded = pcall(HttpService.JSONDecode, HttpService, Config)

		if not DecodeSuccess or type(Decoded) ~= "table" then
			return false, tostring(Decoded)
		end

		self:BeginSilent()
		self.LoadingConfig = true

		local FailedEntries = {}

		for Index, Value in Decoded do
			if Library:IsScriptConfigFlag(Index) ~= true then
				continue
			end

			local ApplySuccess, ApplyError = pcall(function()
				return self:ApplyConfigEntry(Index, Value)
			end)

			if not ApplySuccess then
				TableInsert(FailedEntries, tostring(Index) .. ": " .. tostring(ApplyError))
			end
		end

		self.LoadingConfig = false
		self:EndSilent()

		self:FireConfigFlagCallbacks(Decoded)

		for _, Callback in self.ConfigLoadedCallbacks do
			Library:SafeCall(Callback, #FailedEntries == 0, FailedEntries)
		end

		if #FailedEntries > 0 then
			return false, FailedEntries[1]
		end

		return true
	end

	Library.RefreshConfigsList = function(self, Element)
		local List = {}
		local ReturnList = {}

		List = listfiles(Library:GetFolder())

		for Index = 1, #List do 
			local File = List[Index]

			if File:sub(-5) == ".json" then
				local Position = File:find(".json", 1, true)
				local StartPosition = Position

				local Character = File:sub(Position, Position)

				while Character ~= "/" and Character ~= "\\" and Character ~= "" do
					Position = Position - 1
					Character = File:sub(Position, Position)
				end

				if Character == "/" or Character == "\\" then
					TableInsert(ReturnList, File:sub(Position + 1, StartPosition - 1))
				end
			end
		end

		Element:Refresh(ReturnList)
	end

	Library.GetTheme = function(self)
		local Config = {} 

		local Success, Result = Library:SafeCall(function()
			for Index, Value in Library.Flags do 
				if type(Value) == "table" and Value.Color and StringFind(Value.Flag, "ThemingThing") then
					Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
				end
			end
		end)

		return HttpService:JSONEncode(Config)
	end

	Library.LoadTheme = function(self, Config)
		local Decoded = HttpService:JSONDecode(Config)

		local Success, Result = Library:SafeCall(function()
			for Index, Value in Decoded do 
				local SetFunction = Library.SetFlags[Index]

				if not SetFunction then
					continue
				end

				if type(Value) == "table" and Value.Color then
					SetFunction(Value.Color, Value.Alpha)
				end
			end
		end)

		return Success, Result
	end

	Library.RefreshThemeList = function(self, Element)
		local List = {}
		local ReturnList = {}

		List = listfiles(GetFolders().Themes)

		for Index = 1, #List do 
			local File = List[Index]

			if File:sub(-5) == ".json" then
				local Position = File:find(".json", 1, true)
				local StartPosition = Position

				local Character = File:sub(Position, Position)

				while Character ~= "/" and Character ~= "\\" and Character ~= "" do
					Position = Position - 1
					Character = File:sub(Position, Position)
				end

				if Character == "/" or Character == "\\" then
					TableInsert(ReturnList, File:sub(Position + 1, StartPosition - 1))
				end
			end
		end

		Element:Refresh(ReturnList)
	end

	Library.ChangeItemTheme = function(self, Item, Properties)
		Item = Item.Instance or Item

		if not self.ThemeMap[Item] then 
			return
		end

		self.ThemeMap[Item].Properties = Properties
		self.ThemeMap[Item] = self.ThemeMap[Item]
	end

	Library.ChangeTheme = function(self, Theme, Color)
		self.Theme[Theme] = Color

		for _, Item in self.ThemeItems do
			for Property, Value in Item.Properties do
				if type(Value) == "string" and Value == Theme then
					Item.Item[Property] = Color
				elseif type(Value) == "function" then
					Item.Item[Property] = Value()
				end
			end
		end
	end

	Library.IsMouseOverFrame = function(self, Frame)
		Frame = Frame.Instance

		local MousePosition = Vector2New(Mouse.X, Mouse.Y)

		return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
			and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
	end

	Library.BindDescriptionColor = function(self, Item, DescriptionColor)
		if not DescriptionColor then
			Item:AddToTheme({TextColor3 = "Text"})
		end

		return Item
	end

	Library.BindRowTextInset = function(self, TextItem, DescriptionItem, ControlsFrame, FixedRightReserve, Gap)
		local text_instance = TextItem and TextItem.Instance
		local description_instance = DescriptionItem and DescriptionItem.Instance
		local controls_instance = ControlsFrame and ControlsFrame.Instance
		if not text_instance then
			return
		end

		FixedRightReserve = FixedRightReserve or 40
		Gap = Gap or 8

		local function refresh()
			local reserve = FixedRightReserve + Gap
			if controls_instance and controls_instance.Parent then
				reserve = reserve + controls_instance.AbsoluteSize.X
			end
			text_instance.Size = UDim2New(1, -reserve, 0, 0)
			if description_instance and description_instance.Parent then
				description_instance.Size = UDim2New(1, -reserve, 0, 0)
			end
		end

		if controls_instance then
			controls_instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(refresh)
		end

		refresh()
	end

	Library.ApplyMouseForMenu = function(self, IsOpen)
		if IsOpen then
			self.MouseStateBeforeOpen = {
				MouseBehavior = UserInputService.MouseBehavior,
				MouseIconEnabled = UserInputService.MouseIconEnabled,
			}

			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = false
		elseif self.MouseStateBeforeOpen then
			UserInputService.MouseBehavior = self.MouseStateBeforeOpen.MouseBehavior or Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = self.MouseStateBeforeOpen.MouseIconEnabled ~= false
			self.MouseStateBeforeOpen = nil
		else
			UserInputService.MouseIconEnabled = true
		end

		if self.CursorGui and self.CursorGui.Instance then
			self.CursorGui.Instance.Enabled = self.WindowOpenState
		end

		if self.MouseCursor and self.MouseCursor.Instance then
			self.MouseCursor.Instance.Visible = self.WindowOpenState
		end
	end

	Library.GetSolixScreenGuis = function(self)
		local Guis = {}

		local function Track(Root)
			if not Root then
				return
			end

			if Root:IsA("ScreenGui") then
				Guis[Root] = true
				return
			end

			local ScreenGui = Root:FindFirstAncestorOfClass("ScreenGui")
			if ScreenGui then
				Guis[ScreenGui] = true
			end
		end

		Track(self.Holder and self.Holder.Instance)
		Track(self.InputBlockGui and self.InputBlockGui.Instance)
		Track(self.FloatingButtonHolder and self.FloatingButtonHolder.Instance)
		Track(self.OtherHolder and self.OtherHolder.Instance)
		Track(self.UnusedHolder and self.UnusedHolder.Instance)
		Track(self.WatermarkGui and self.WatermarkGui.Instance)
		Track(self.CursorGui and self.CursorGui.Instance)

		return Guis
	end

	Library.GetSolixGuiRoots = function(self)
		local Roots = {}

		if self.Holder and self.Holder.Instance then
			TableInsert(Roots, self.Holder.Instance)
		end

		if self.FloatingButtonHolder and self.FloatingButtonHolder.Instance then
			TableInsert(Roots, self.FloatingButtonHolder.Instance)
		end

		if self.WatermarkGui and self.WatermarkGui.Instance then
			TableInsert(Roots, self.WatermarkGui.Instance)
		end

		if self.CursorGui and self.CursorGui.Instance then
			TableInsert(Roots, self.CursorGui.Instance)
		end

		return Roots
	end

	Library.SetExternalGuisBlocked = function(self, Bool)
		if not self.ExternalGuiStates then
			self.ExternalGuiStates = {}
		end

		local SolixGuis = self:GetSolixScreenGuis()

		local function ProcessRoot(Root)
			if not Root then
				return
			end

			for _, Child in Root:GetChildren() do
				if not Child:IsA("ScreenGui") then
					continue
				end

				if SolixGuis[Child] then
					continue
				end

				if Bool then
					if Child.Enabled then
						self.ExternalGuiStates[Child] = true
						Child.Enabled = false
					end
				elseif self.ExternalGuiStates[Child] then
					Child.Enabled = true
					self.ExternalGuiStates[Child] = nil
				end
			end
		end

		if Bool then
			ProcessRoot(SafeGetUI())

			local PlayerGui = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
			if PlayerGui then
				ProcessRoot(PlayerGui)
			end

			return
		end

		for Gui, WasEnabled in self.ExternalGuiStates do
			if Gui and Gui.Parent and WasEnabled then
				Gui.Enabled = true
			end
		end

		self.ExternalGuiStates = {}
	end

	Library.IsSolixGuiObject = function(self, Object)
		if not Object then
			return false
		end

		for _, Root in self:GetSolixGuiRoots() do
			if Object == Root or Object:IsDescendantOf(Root) then
				return true
			end
		end

		return false
	end

	Library.IsPointerOverSolixGui = function(self)
		local MouseLocation = GetMouseLocation()
		local Objects = GuiService:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y)

		for _, Object in Objects do
			if self:IsSolixGuiObject(Object) then
				return true
			end
		end

		return false
	end

	Library.ApplyWindowInputState = function(self, Bool)
		if self.InputBlockGui and self.InputBlockGui.Instance then
			self.InputBlockGui.Instance.Enabled = Bool and true or false
		end

		if self.InputBlocker and self.InputBlocker.Instance then
			self.InputBlocker.Instance.Visible = Bool and true or false
		end

		if self.Holder and self.Holder.Instance then
			self.Holder.Instance.DisplayOrder = Bool and self.DisplayOrders.HolderOpen or self.DisplayOrders.Holder
		end

		if self.FloatingButtonHolder and self.FloatingButtonHolder.Instance then
			self.FloatingButtonHolder.Instance.DisplayOrder = Bool and self.DisplayOrders.FloatingButtonOpen or self.DisplayOrders.FloatingButton
		end

		if self.OtherHolder and self.OtherHolder.Instance then
			self.OtherHolder.Instance.Enabled = not Bool
		end

		self:SetExternalGuisBlocked(Bool)

		if Bool then
			ContextActionService:BindActionAtPriority(self.InputBlockAction, function(_, State, Input)
				if State ~= Enum.UserInputState.Begin and State ~= Enum.UserInputState.Change then
					return Enum.ContextActionResult.Pass
				end

				if not self.WindowOpenState or UserInputService:GetFocusedTextBox() then
					return Enum.ContextActionResult.Pass
				end

				if Input and (tostring(Input.KeyCode) == self.MenuKeybind or tostring(Input.UserInputType) == self.MenuKeybind) then
					return Enum.ContextActionResult.Pass
				end

				return Enum.ContextActionResult.Sink
			end, false, 5000,
				Enum.UserInputType.Gamepad1,
				Enum.UserInputType.Gamepad2,
				Enum.UserInputType.Gamepad3,
				Enum.UserInputType.Gamepad4,
				Enum.UserInputType.Gamepad5,
				Enum.UserInputType.Gamepad6,
				Enum.UserInputType.Gamepad7,
				Enum.UserInputType.Gamepad8,
				Enum.UserInputType.MouseWheel,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3
			)

			ContextActionService:BindActionAtPriority(self.InputBlockAction .. "_KEYS", function(_, State)
				if State ~= Enum.UserInputState.Begin and State ~= Enum.UserInputState.Change then
					return Enum.ContextActionResult.Pass
				end

				if not self.WindowOpenState or UserInputService:GetFocusedTextBox() then
					return Enum.ContextActionResult.Pass
				end

				return Enum.ContextActionResult.Sink
			end, false, 5000, table.unpack(BlockedWindowInputs))

			ContextActionService:BindActionAtPriority(self.InputBlockAction .. "_MOUSE", function(_, State, Input)
				if State ~= Enum.UserInputState.Begin and State ~= Enum.UserInputState.Change then
					return Enum.ContextActionResult.Pass
				end

				if not self.WindowOpenState or UserInputService:GetFocusedTextBox() then
					return Enum.ContextActionResult.Pass
				end

				if self:IsPointerOverSolixGui() then
					return Enum.ContextActionResult.Pass
				end

				return Enum.ContextActionResult.Sink
			end, false, 5000, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch)

			return
		end

		ContextActionService:UnbindAction(self.InputBlockAction)
		ContextActionService:UnbindAction(self.InputBlockAction .. "_KEYS")
		ContextActionService:UnbindAction(self.InputBlockAction .. "_MOUSE")
	end

	Library.SetupBackgroundEffects = function(self)
		if self.BackgroundEffects then
			return
		end

		local Camera = Workspace.CurrentCamera
		if not Camera then
			defer(function()
				local Attempts = 0

				while not Workspace.CurrentCamera and Library and Attempts < 100 do
					wait(0.1)
					Attempts += 1
				end

				if Library and not Library.BackgroundEffects then
					Library:SetupBackgroundEffects()
				end
			end)

			return
		end

		if not self.InputBlockGui or not self.InputBlockGui.Instance then
			return
		end

		local Viewport = Camera.ViewportSize

		local Background = Instances:Create("Frame", {
			Parent = self.InputBlockGui.Instance,
			Name = "\0",
			BackgroundColor3 = FromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2New(0, 0, 0, 0),
			Size = UDim2FromOffset(Viewport.X, Viewport.Y),
			Visible = false,
			Active = false,
			ZIndex = 0,
		})

		local ParticleHolder = Instances:Create("Frame", {
			Parent = Background.Instance,
			Name = "\0",
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Position = UDim2New(0, 0, 0, 0),
			Size = UDim2New(1, 0, 1, 0),
			ZIndex = 0,
		})

		local BlurEffect = InstanceNew("BlurEffect")
		BlurEffect.Name = "\0"
		BlurEffect.Size = 0
		BlurEffect.Parent = Camera

		self.BackgroundEffects = {
			Background = Background.Instance,
			ParticleHolder = ParticleHolder.Instance,
			BlurEffect = BlurEffect,
			ScreenGui = self.InputBlockGui.Instance,
			SnowAsset = "rbxassetid://6871196088",
			IsParticleActive = false,
		}

		local function ResizeBackground()
			local CurrentCamera = Workspace.CurrentCamera
			if not CurrentCamera or not self.BackgroundEffects then
				return
			end

			local Size = CurrentCamera.ViewportSize
			self.BackgroundEffects.Background.Size = UDim2FromOffset(Size.X, Size.Y)
		end

		local function SpawnSnow(Effects, Holder, Width, Height)
			local Image = InstanceNew("ImageLabel")
			Image.Name = "\0"
			Image.Parent = Holder
			Image.BackgroundTransparency = 1
			Image.Image = Effects.SnowAsset
			Image.ImageTransparency = 0.15
			Image.ZIndex = 0

			local RandomSize = math.random(5, 9)
			local SpawnX = math.random(0, math.max(0, Width - RandomSize))

			Image.Size = UDim2New(0, RandomSize, 0, RandomSize)
			Image.Position = UDim2New(0, SpawnX, 0, -10)

			local FallDuration = math.random(20, 40) / 10
			local SwayX = math.random(-18, 18)
			local GoalPosition = UDim2New(0, SpawnX + SwayX, 0, Height + 10)

			local FallTween = TweenService:Create(Image, TweenInfo.new(FallDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Position = GoalPosition,
				ImageTransparency = 1,
			})

			FallTween:Play()
			Library:Connect(FallTween.Completed, function()
				if Image and Image.Parent then
					Image:Destroy()
				end
			end)
		end

		local function SpawnRain(Effects, Holder, Width, Height)
			local Image = InstanceNew("ImageLabel")
			Image.Name = "\0"
			Image.Parent = Holder
			Image.BackgroundTransparency = 1
			Image.Image = Effects.SnowAsset
			Image.ImageColor3 = FromRGB(175, 195, 255)
			Image.ImageTransparency = 0.35
			Image.ZIndex = 0

			local RandomSize = math.random(3, 6)
			local SpawnX = math.random(0, math.max(0, Width - RandomSize))

			Image.Size = UDim2New(0, RandomSize, 0, RandomSize * 2)
			Image.Position = UDim2New(0, SpawnX, 0, -12)

			local FallDuration = math.random(8, 14) / 10
			local SwayX = math.random(10, 24)
			local GoalPosition = UDim2New(0, SpawnX + SwayX, 0, Height + 12)

			local FallTween = TweenService:Create(Image, TweenInfo.new(FallDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Position = GoalPosition,
				ImageTransparency = 1,
			})

			FallTween:Play()
			Library:Connect(FallTween.Completed, function()
				if Image and Image.Parent then
					Image:Destroy()
				end
			end)
		end

		ResizeBackground()
		self:Connect(Camera:GetPropertyChangedSignal("ViewportSize"), ResizeBackground, "BackgroundEffectsResize")

		self:Thread(function()
			while Library and Library.BackgroundEffects do
				local Effects = Library.BackgroundEffects
				local EffectType = Library.BackgroundEffect or "None"

				if not Effects.IsParticleActive or EffectType == "None" then
					wait(0.1)
					continue
				end

				local Holder = Effects.ParticleHolder
				if not Holder or not Holder.Parent then
					wait(0.1)
					continue
				end

				local Width = Holder.AbsoluteSize.X
				local Height = Holder.AbsoluteSize.Y

				if Width <= 0 or Height <= 0 then
					wait(0.1)
					continue
				end

				if EffectType == "Snow" then
					SpawnSnow(Effects, Holder, Width, Height)
					wait(0.1)
				elseif EffectType == "Rain" then
					SpawnRain(Effects, Holder, Width, Height)
					wait(0.04)
				else
					wait(0.1)
				end
			end
		end)
	end

	Library.ClearBackgroundParticles = function(self)
		local Effects = self.BackgroundEffects
		if not Effects or not Effects.ParticleHolder then
			return
		end

		for _, Child in Effects.ParticleHolder:GetChildren() do
			if Child:IsA("GuiObject") then
				Child:Destroy()
			end
		end
	end

	Library.SetBackgroundEffectsVisible = function(self, IsOpen, Instant)
		local Effects = self.BackgroundEffects
		if not Effects then
			return
		end

		local HasDarken = self.BackgroundDarkenEnabled
		local HasParticles = self.BackgroundEffect and self.BackgroundEffect ~= "None"
		local HasAnyEffect = HasDarken or HasParticles
		local IsVisible = IsOpen and true or false

		Effects.IsParticleActive = IsVisible and HasParticles

		local TargetTransparency = (IsVisible and HasDarken) and 0.55 or 1
		local TargetBlur = (IsVisible and HasDarken) and 18 or 0

		if Effects.ScreenGui and not self.WindowOpenState then
			Effects.ScreenGui.Enabled = IsVisible and HasAnyEffect
		end

		if IsVisible and HasAnyEffect then
			Effects.Background.Visible = true

			local CurrentCamera = Workspace.CurrentCamera
			if CurrentCamera then
				local Size = CurrentCamera.ViewportSize
				Effects.Background.Size = UDim2FromOffset(Size.X, Size.Y)
			end
		end

		if Instant then
			Effects.Background.BackgroundTransparency = TargetTransparency
			Effects.BlurEffect.Size = TargetBlur
		else
			TweenService:Create(Effects.Background, TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				BackgroundTransparency = TargetTransparency,
			}):Play()

			TweenService:Create(Effects.BlurEffect, TweenInfo.new(0.33, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Size = TargetBlur,
			}):Play()
		end

		if not IsVisible or not HasAnyEffect then
			delay(0.35, function()
				if not Library or not Library.BackgroundEffects then
					return
				end

				local CurrentEffects = Library.BackgroundEffects
				if CurrentEffects.IsParticleActive then
					return
				end

				CurrentEffects.Background.Visible = false

				if CurrentEffects.ScreenGui then
					CurrentEffects.ScreenGui.Enabled = false
				end

				Library:ClearBackgroundParticles()
			end)
		end
	end

	Library.SetBackgroundDarkenEnabled = function(self, Bool, SkipSave)
		self.BackgroundDarkenEnabled = Bool and true or false
		self:SetBackgroundEffectsVisible(self.WindowOpenState, true)

		if not self.LoadingConfig and SkipSave ~= true then
			self:SaveLocalSettings()
		end
	end

	Library.SetBackgroundEffect = function(self, Value, SkipSave)
		if type(Value) == "boolean" then
			Value = Value and "Snow" or "None"
		elseif type(Value) == "string" then
			Value = Value:match("^%s*(.-)%s*$")
		end

		if Value == "Shooting Stars" then
			Value = "Snow"
		end

		local IsValid = false
		for _, Option in self.BackgroundEffectOptions do
			if Option == Value then
				IsValid = true
				break
			end
		end

		if not IsValid then
			Value = "None"
		end

		if self.BackgroundEffect == Value then
			self:SetBackgroundEffectsVisible(self.WindowOpenState, true)
			return
		end

		self.BackgroundEffect = Value
		self:ClearBackgroundParticles()
		self:SetBackgroundEffectsVisible(self.WindowOpenState, true)

		if not SkipSave then
			self:SaveLocalSettings()
		end
	end

	Library:SetupBackgroundEffects()
	Library:SetBackgroundEffectsVisible(false, true)
	Library:ApplyWindowInputState(false)

	Library.Lerp = function(self, Start, Finish, Time)
		return Start + (Finish - Start) * Time
	end

	Library.CompareVectors = function(self, PointA, PointB)
		return (PointA.X < PointB.X) and (PointA.Y < PointB.Y)
	end

	Library.IsClipped = function(self, Object, Column)
		local Parent = Column

		local BoundryTop = Parent.AbsolutePosition
		local BoundryBottom = BoundryTop + Parent.AbsoluteSize

		local Top = Object.AbsolutePosition
		local Bottom = Top + Object.AbsoluteSize 

		return Library:CompareVectors(Top, BoundryTop) or Library:CompareVectors(BoundryBottom, Bottom)
	end

	Library.GetFolder = function(self)
		return GetFolders().Configurations .. "/" .. GameId .. "/"
	end 

	Library.GetFolderTheme = function(self)
		return GetFolders().Themes .. "/"
	end

	Library.SaveAutoloadIfEnabled = function(self)
		if not self.LoadingConfig and self.AutoSave then
			pcall(function()
				writefile(GetAutoloadPath(), self:GetConfig())
			end)
		end
	end

	Library.LoadLocalSettings = function(self)
		local SettingsPath = GetLocalSettingsPath()

		if not isfile(SettingsPath) then
			return
		end

		local Success, Decoded = pcall(function()
			return HttpService:JSONDecode(readfile(SettingsPath))
		end)

		if not Success or type(Decoded) ~= "table" then
			return
		end

		if type(Decoded.SafeMode) == "boolean" then
			self.SafeMode = Decoded.SafeMode
		end

		if type(Decoded.AutoloadConfigEnabled) == "boolean" then
			self.AutoloadConfigEnabled = Decoded.AutoloadConfigEnabled
		end

		if type(Decoded.AutoloadThemeEnabled) == "boolean" then
			self.AutoloadThemeEnabled = Decoded.AutoloadThemeEnabled
		end

		if type(Decoded.BackgroundEffect) == "string" then
			local Effect = Decoded.BackgroundEffect
			if Effect == "Shooting Stars" then
				Effect = "Snow"
			end
			self:SetBackgroundEffect(Effect, true)
		elseif Decoded.BackgroundSnowEnabled == false then
			self:SetBackgroundEffect("None", true)
		elseif Decoded.BackgroundSnowEnabled == true then
			self:SetBackgroundEffect("Snow", true)
		end

		if Decoded.BackgroundDarkenEnabled == false then
			self.BackgroundDarkenEnabled = false
		elseif Decoded.BackgroundDarkenEnabled == true then
			self.BackgroundDarkenEnabled = true
		end

		if type(Decoded.ShowWatermark) == "boolean" then
			self.ShowWatermark = Decoded.ShowWatermark
		end

		if type(Decoded.ShowKeybindList) == "boolean" then
			self.ShowKeybindList = Decoded.ShowKeybindList
		end

		if type(Decoded.ShowMenuButton) == "boolean" then
			self.ShowMenuButton = Decoded.ShowMenuButton
		elseif type(Decoded.ShowFloatingButton) == "boolean" then
			self.ShowMenuButton = Decoded.ShowFloatingButton
		end

		if type(Decoded.AutoExecute) == "boolean" then
			self.AutoExecute = Decoded.AutoExecute
		end

		if type(Decoded.LanguagePreset) == "string" and self.LanguageToCode[Decoded.LanguagePreset] then
			self:ApplyLanguagePreset(Decoded.LanguagePreset)
		end

		if type(Decoded.BackgroundTransparency) == "number" then
			self.BackgroundTransparency = MathClamp(Decoded.BackgroundTransparency, 0, 1)
		end

		if type(Decoded.MenuTweenTime) == "number" then
			self.Tween.Time = Decoded.MenuTweenTime
		end

		if type(Decoded.MenuFadeTime) == "number" then
			self.FadeSpeed = Decoded.MenuFadeTime
		end

		if type(Decoded.MenuScalePreset) == "string" then
			self.MenuScalePreset = Decoded.MenuScalePreset
		end

		if type(Decoded.MenuTweenStyle) == "string" and Enum.EasingStyle[Decoded.MenuTweenStyle] then
			self.MenuTweenStyle = Decoded.MenuTweenStyle
			self.Tween.Style = Enum.EasingStyle[Decoded.MenuTweenStyle]
		end

		if type(Decoded.MenuTweenDirection) == "string" and Enum.EasingDirection[Decoded.MenuTweenDirection] then
			self.MenuTweenDirection = Decoded.MenuTweenDirection
			self.Tween.Direction = Enum.EasingDirection[Decoded.MenuTweenDirection]
		end

		if type(Decoded.UIFont) == "string" and self.FontFaces[Decoded.UIFont] then
			self:SetFont(Decoded.UIFont, true)
		end

		if type(Decoded.UIMainTextSize) == "number" then
			self:SetTextSizes(Decoded.UIMainTextSize, nil, nil, true)
		end

		if type(Decoded.UISmallTextSize) == "number" then
			self:SetTextSizes(nil, Decoded.UISmallTextSize, nil, true)
		end

		if type(Decoded.UITitleTextSize) == "number" then
			self:SetTextSizes(nil, nil, Decoded.UITitleTextSize, true)
		end
	end

	Library.SaveLocalSettings = function(self)
		local SettingsPath = GetLocalSettingsPath()
		local Settings = {
			SafeMode = self.SafeMode == true,
			AutoloadConfigEnabled = self.AutoloadConfigEnabled == true,
			AutoloadThemeEnabled = self.AutoloadThemeEnabled == true,
			BackgroundEffect = self.BackgroundEffect or "Snow",
			BackgroundDarkenEnabled = self.BackgroundDarkenEnabled ~= false,
			ShowWatermark = self.ShowWatermark == true,
			ShowKeybindList = self.ShowKeybindList == true,
			ShowMenuButton = self.ShowMenuButton ~= false,
			AutoExecute = self.AutoExecute == true,
			LanguagePreset = self.LanguagePreset or "Auto",
			BackgroundTransparency = self.BackgroundTransparency,
			MenuTweenTime = self.Tween.Time,
			MenuFadeTime = self.FadeSpeed,
			MenuScalePreset = self.MenuScalePreset or "Medium",
			MenuTweenStyle = self.MenuTweenStyle or "Cubic",
			MenuTweenDirection = self.MenuTweenDirection or "Out",
			UIFont = self.FontSettings.Name,
			UIMainTextSize = self.FontSettings.TextSize,
			UISmallTextSize = self.FontSettings.SmallTextSize,
			UITitleTextSize = self.FontSettings.TitleTextSize,
		}

		pcall(function()
			writefile(SettingsPath, HttpService:JSONEncode(Settings))
		end)
	end

	Library.ApplyMenuSettingsFromLocal = function(self, Watermark, KeybindList, Window)
		local ActiveWatermark = Watermark or self.WatermarkInstance
		local ActiveKeybindList = KeybindList or self.KeyList

		if ActiveWatermark and ActiveWatermark.SetVisibility then
			ActiveWatermark:SetVisibility(self.ShowWatermark == true)
		end

		if ActiveKeybindList and ActiveKeybindList.SetVisibility then
			ActiveKeybindList:SetVisibility(self.ShowKeybindList == true)
		end

		if self.FloatingButtonHolder and self.FloatingButtonHolder.Instance then
			self.FloatingButtonHolder.Instance.Enabled = self.ShowMenuButton ~= false
		end

		if Window and Window.SetTransparency and type(self.BackgroundTransparency) == "number" then
			Window:SetTransparency(self.BackgroundTransparency)
		end

		if ActiveKeybindList and ActiveKeybindList.SetTransparency and type(self.BackgroundTransparency) == "number" then
			ActiveKeybindList:SetTransparency(self.BackgroundTransparency)
		end

		self:SetBackgroundDarkenEnabled(self.BackgroundDarkenEnabled, true)
	end

	Library.SyncMenuSettingsToUI = function(self, Silent)
		local MenuSettingFlags = {
			["Show Watermark"] = function()
				return self.ShowWatermark == true
			end,
			["Show Keybind List"] = function()
				return self.ShowKeybindList == true
			end,
			["Show Menu Button"] = function()
				return self.ShowMenuButton ~= false
			end,
			["Background Darken"] = function()
				return self.BackgroundDarkenEnabled ~= false
			end,
		}

		if Silent == true then
			self:BeginSilent()
		end

		for Flag, GetValue in MenuSettingFlags do
			local Setter = self.SetFlags[Flag]
			if type(Setter) == "function" then
				Setter(GetValue())
			end
		end

		if Silent == true then
			self:EndSilent()
		end
	end

	Library.FinalizeMenuSettings = function(self, Watermark, KeybindList, Window)
		self:CheckForAutoLoad()
		self:LoadLocalSettings()
		self:SyncMenuSettingsToUI(true)
		self:ApplyMenuSettingsFromLocal(Watermark, KeybindList, Window)
		self:EndUILoading()
	end

	Library.CheckForThemeAutoLoad = function(self)
		if not self.AutoloadThemeEnabled then
			return
		end

		local ThemeNamePath = GetAutoloadThemeNamePath()

		if not isfile(ThemeNamePath) then
			return
		end

		local ThemeName = readfile(ThemeNamePath)

		if not ThemeName or ThemeName == "" then
			return
		end

		local ThemePath = self:GetFolderTheme() .. ThemeName .. ".json"

		if not isfile(ThemePath) then
			return
		end

		local Success, Error = self:LoadTheme(readfile(ThemePath))

		if Success then
			self:Notification({
				Name = "Success",
				Description = "Succesfully autoloaded theme: " .. ThemeName,
				Color = Color3.fromRGB(0, 255, 0),
				Duration = 5,
			})
		else
			self:Notification({
				Name = "Error",
				Description = "Failed to autoload theme: " .. tostring(Error),
				Color = Color3.fromRGB(255, 0, 0),
				Duration = 5,
			})
		end
	end

	Library.CheckForAutoLoad = function(self)
		self:CheckForThemeAutoLoad()

		if self.AutoloadConfigEnabled then
			local ConfigNamePath = GetAutoloadConfigNamePath()

			if isfile(ConfigNamePath) then
				local ConfigName = readfile(ConfigNamePath)

				if ConfigName and ConfigName ~= "" then
					local ConfigPath = self:GetFolder() .. ConfigName .. ".json"

					if isfile(ConfigPath) then
						local Success, Error = self:LoadConfig(readfile(ConfigPath))

						if Success then
							self:Notification({
								Name = "Success",
								Description = "Succesfully autoloaded config: " .. ConfigName,
								Color = Color3.fromRGB(0, 255, 0),
								Duration = 5,
							})
						else
							self:Notification({
								Name = "Error",
								Description = "Failed to autoload config: " .. tostring(Error),
								Color = Color3.fromRGB(255, 0, 0),
								Duration = 5,
							})
						end

						return
					end
				end
			end
		end

		local AutoLoadPath = GetAutoloadPath()

		if not isfile(AutoLoadPath) then
			return
		end

		local ConfigContent = readfile(AutoLoadPath)

		if ConfigContent == "" then
			return
		end

		local Success, Error = Library:LoadConfig(ConfigContent)

		if Success then
			Library:Notification({
				Name = "Success",
				Description = "Succesfully autoloaded config",
				Color = Color3.fromRGB(0, 255, 0),
				Duration = 5
			})
		else
			Library:Notification({
				Name = "Error",
				Description = "Failed to load config: " .. (Error or "Unknown error"),
				Color = Color3.fromRGB(255, 0, 0),
				Duration = 5
			})
		end
	end
	Library.Sections.Toggle = function(self, Data)
		Data = Data or {}

		local Toggle = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Data.Name or Data.name or "Toggle",
			Description = Data.Description or Data.description or nil,
			DescriptionColor = Data.DescriptionColor or Data.description_color or nil,
			Flag = Library:ResolveElementFlag(Data),
			Default = Data.Default or Data.default or false,
			Tooltip = Data.Tooltip or Data.tooltip or nil,
			Callback = Data.Callback or Data.callback or function() end,
			Lifetime = Data.Lifetime or Data.lifetime or false,

			Value = false,
			Disabled = false,
		}

		local Items = {} do 
			Items["Toggle"] = Instances:Create("TextButton", {
				Parent = Toggle.Section.Items["Content"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, Toggle.Description and Toggle.Description ~= "" and 40 or 20),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 2
			})

			Items["Toggle"]:Tooltip(Toggle.Tooltip)

			Items["Text"] = Instances:Create("TextLabel", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 15),
				Position = UDim2New(0, 0, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Toggle.Name,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				AutomaticSize = Enum.AutomaticSize.X,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})

			if Toggle.Description and Toggle.Description ~= "" then
				Items["Description"] = Instances:Create("TextLabel", {
					Parent = Items["Toggle"].Instance,
					Name = "\0",
					Size = UDim2New(0, 0, 0, 15),
					Position = UDim2New(0, 0, 0, 22),
					AnchorPoint = Vector2New(0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Text = Toggle.Description,
					TextColor3 = Toggle.DescriptionColor or Library.Theme["Text"],
					TextSize = 14,
					FontFace = Library.Font,
					TextTransparency = 0.4000000059604645,
					AutomaticSize = Enum.AutomaticSize.X,
					ZIndex = 2
				})

				Library:BindDescriptionColor(Items["Description"], Toggle.DescriptionColor)
			end

			Items["Indicator"] = Instances:Create("TextButton", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				Size = UDim2New(0, 40, 0, 20),
				Position = UDim2New(1, 0, 0.5, 0),
				AnchorPoint = Vector2New(1, 0.5),
				BackgroundColor3 = Library.Theme["Element"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				AutoButtonColor = false,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Element'})

			Instances:Create("UICorner", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})

			Instances:Create("UIGradient", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				Rotation = 90,
				Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
			})

			Items["Circle"] = Instances:Create("Frame", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				Size = UDim2New(0, 14, 0, 14),
				Position = UDim2New(0, 3, 0, 3),
				BackgroundTransparency = 0.4000000059604645,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = function()
				return FromRGB(255, 255, 255)
			end})

			Instances:Create("UICorner", {
				Parent = Items["Circle"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})				

			Items["SubElements"] = Instances:Create("Frame", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 1, 0),
				Position = UDim2New(1, -48, 0, 0),
				AnchorPoint = Vector2New(1, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0
			})

			Instances:Create("UIListLayout", {
				Parent = Items["SubElements"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Center
			})			
		end

		function Toggle:Get()
			return Toggle.Value 
		end

		function Toggle:Set(Value, Silent)
			if Toggle.Disabled then
				return
			end

			if not Library:CheckLifetime(Toggle) then
				return
			end

			Toggle.Value = Value
			if Toggle.Flag then
				Library.Flags[Toggle.Flag] = Value
			end

			local ThemeKey = Value and "Accent" or "Element"
			local TextTrans = Value and 0 or 0.4
			local CircleTrans = Value and 0 or 0.4

			Items["Text"]:Tween(nil, {TextTransparency = TextTrans})

			Items["Circle"]:Tween(TweenInfo.new(Library.Tween.Time + 0.2, Enum.EasingStyle.Quart, Library.Tween.Direction), {
				AnchorPoint = Value and Vector2New(1, 0) or Vector2New(0, 0),
				Position = Value and UDim2New(1, -3, 0, 3) or UDim2New(0, 3, 0, 3),
				BackgroundTransparency = CircleTrans,
			})

			Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = ThemeKey})
			Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme[ThemeKey]})

			if Toggle.Callback and Library:ShouldFireElementCallback(Silent) then
				Library:SafeCall(Toggle.Callback, Toggle.Value)
			end

			if Library:ShouldSaveAutoload(Silent) then
				Library:SaveAutoloadIfEnabled()
			end
		end

		function Toggle:SetDisabled(Bool)
			Toggle.Disabled = Bool

			local TextTrans = Bool and 0.6 or (Toggle.Value and 0 or 0.4)
			local CircleTrans = Bool and 0.6 or (Toggle.Value and 0 or 0.4)
			local IndicatorTrans = Bool and 0.6 or 0

			Items["Text"]:Tween(nil, {TextTransparency = TextTrans})
			Items["Circle"]:Tween(nil, {BackgroundTransparency = CircleTrans})
			Items["Indicator"]:Tween(nil, {BackgroundTransparency = IndicatorTrans})
		end

		function Toggle:SetVisibility(Bool)
			Items["Toggle"].Instance.Visible = Bool 
		end

		function Toggle:Colorpicker(Data)
			Data = Data or {}

			local Colorpicker = {
				Window = Toggle.Window,
				Page = Toggle.Page,
				Section = Toggle.Section,

				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
				Callback = Data.Callback or Data.callback or function() end,
				Alpha = Data.Alpha or Data.alpha or false
			}

			local NewColorpicker = Library:CreateColorpicker({
				Parent = Items["SubElements"],
				Page = Colorpicker.Page,
				Section = Colorpicker.Section,
				Flag = Colorpicker.Flag,
				Default = Colorpicker.Default,
				Callback = Colorpicker.Callback,
				Alpha = Colorpicker.Alpha
			})

			return NewColorpicker
		end

		function Toggle:Keybind(Data)
			Data = Data or {}

			local Keybind = {
				Window = Toggle.Window,
				Page = Toggle.Page,
				Section = Toggle.Section,

				Name = Data.Name or Data.name or Toggle.Name,
				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or KEYBIND_NONE_KEY,
				Callback = Data.Callback or Data.callback or function() end,
				Mode = Data.Mode or Data.mode or "Toggle"
			}

			local NewKeybind = Library:CreateKeybind({
				Parent = Items["SubElements"],
				Page = Keybind.Page,
				Section = Keybind.Section,
				Flag = Keybind.Flag,
				Name = Keybind.Name,
				Default = Keybind.Default,
				Mode = Keybind.Mode,
				Callback = Keybind.Callback
			})

			return NewKeybind
		end

		local PageSearchData = Library.SearchItems[Toggle.Page] 

		if PageSearchData then
			local SearchData = { 
				Element = Items["Toggle"],
				Name = Toggle.Name,
			}

			TableInsert(PageSearchData, SearchData)
		end

		Items["Indicator"]:Connect("InputBegan", function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Toggle:Set(not Toggle.Value)
			end
		end)

		Items["Toggle"]:Connect("MouseButton1Down", function()
			Toggle:Set(not Toggle.Value)
		end)

		Toggle:Set(Toggle.Default, true)

		Library:BindElementFlag(Toggle.Flag, function(Value)
			if Toggle.Disabled then 
				return 
			end
			Toggle:Set(Value, Library.LoadingConfig == true)
		end, Toggle)

		function Toggle:Destroy()
			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end
			return Toggle
		end

		Toggle.Items = Items
		return Toggle 
	end

	Library.CreateColorpicker = function(self, Data)
		local Colorpicker = {
			Hue = 0,
			Saturation = 0,
			Value = 0,
			Alpha = 0,

			Flag = Data.Flag,
			Color = FromRGB(255, 255, 255),
			HexValue = "#FFFFFF",

			Disabled = false,
			IsOpen = false
		}

		local Items = {} do 
			Items["ColorpickerButton"] = Instances:Create("TextButton", {
				Parent = Data.Parent.Instance,
				Name = "\0",
				Size = UDim2New(0, 15, 0, 15),
				Position = UDim2New(0, 0, 0, 0),
				BackgroundColor3 = FromRGB(255, 215, 160),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 2
			})

			Instances:Create("UIGradient", {
				Parent = Items["ColorpickerButton"].Instance,
				Name = "\0",
				Rotation = 90,
				Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
			})

			Instances:Create("UICorner", {
				Parent = Items["ColorpickerButton"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})                

			Items["ColorpickerWindow"] = Instances:Create("TextButton", {
				Parent = Library.UnusedHolder.Instance,
				Name = "\0",
				Size = UDim2New(0, 218, 0, 0),
				Position = UDim2New(0.005806451663374901, 0, 0.016434893012046814, 0),
				BackgroundColor3 = Library.Theme["Background"],
				BackgroundTransparency = 0.30000001192092896,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				ClipsDescendants = true,
				AutoButtonColor = false
			}):AddToTheme({BackgroundColor3 = 'Background'})

			Instances:Create("UICorner", {
				Parent = Items["ColorpickerWindow"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Hue"] = Instances:Create("TextButton", {
				Parent = Items["ColorpickerWindow"].Instance,
				Name = "\0",
				Size = UDim2New(1, -16, 0, 18),
				Position = UDim2New(0, 8, 1, -75),
				AnchorPoint = Vector2New(0, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				AutoButtonColor = false,
				ZIndex = 2
			})

			Instances:Create("UICorner", {
				Parent = Items["Hue"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["HueDragger"] = Instances:Create("Frame", {
				Parent = Items["Hue"].Instance,
				Name = "\0",
				Size = UDim2New(0, 2, 1, -10),
				Position = UDim2New(0, 12, 0.5, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			})

			Instances:Create("UIStroke", {
				Parent = Items["HueDragger"].Instance,
				Name = "\0",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 1.2000000476837158
			})

			Instances:Create("UICorner", {
				Parent = Items["HueDragger"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})

			Instances:Create("UIGradient", {
				Parent = Items["Hue"].Instance,
				Name = "\0",
				Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 0, 0)), RGBSequenceKeypoint(0.17, FromRGB(255, 255, 0)), RGBSequenceKeypoint(0.33, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(0, 255, 255)), RGBSequenceKeypoint(0.67, FromRGB(0, 0, 255)), RGBSequenceKeypoint(0.83, FromRGB(255, 0, 255)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
			})                

			Items["Alpha"] = Instances:Create("TextButton", {
				Parent = Items["ColorpickerWindow"].Instance,
				Name = "\0",
				Size = UDim2New(0, 18, 1, -110),
				Position = UDim2New(1, -8, 0, 8),
				AnchorPoint = Vector2New(1, 0),
				BackgroundColor3 = FromRGB(255, 215, 160),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 2
			})

			Instances:Create("UICorner", {
				Parent = Items["Alpha"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["AlphaDragger"] = Instances:Create("Frame", {
				Parent = Items["Alpha"].Instance,
				Name = "\0",
				Size = UDim2New(1, -10, 0, 2),
				Position = UDim2New(0.5, 0, 0, 3),
				AnchorPoint = Vector2New(0.5, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			})

			Instances:Create("UIStroke", {
				Parent = Items["AlphaDragger"].Instance,
				Name = "\0",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 1.2000000476837158
			})

			Instances:Create("UICorner", {
				Parent = Items["AlphaDragger"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})

			Items["Checkers"] = Instances:Create("ImageLabel", {
				Parent = Items["Alpha"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://18274452449",
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2New(0, 6, 0, 6),
				ZIndex = 2
			})

			Instances:Create("UIGradient", {
				Parent = Items["Checkers"].Instance,
				Name = "\0",
				Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(0.37, 0.5), NumSequenceKeypoint(1, 0)},
				Rotation = 90
			})

			Instances:Create("UICorner", {
				Parent = Items["Checkers"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Palette"] = Instances:Create("TextButton", {
				Parent = Items["ColorpickerWindow"].Instance,
				Name = "\0",
				Size = UDim2New(1, -44, 1, -110),
				Position = UDim2New(0, 9, 0, 8),
				BackgroundColor3 = FromRGB(255, 215, 160),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 2
			})

			Instances:Create("UICorner", {
				Parent = Items["Palette"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Saturation"] = Instances:Create("ImageLabel", {
				Parent = Items["Palette"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://130624743341203",
				ZIndex = 2
			})

			Instances:Create("UICorner", {
				Parent = Items["Saturation"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Value"] = Instances:Create("ImageLabel", {
				Parent = Items["Palette"].Instance,
				Name = "\0",
				Size = UDim2New(1, 2, 1, 0),
				Position = UDim2New(0, -1, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://96192970265863",
				ZIndex = 3
			})

			Instances:Create("UICorner", {
				Parent = Items["Value"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["PaletteDragger"] = Instances:Create("Frame", {
				Parent = Items["Palette"].Instance,
				Name = "\0",
				Size = UDim2New(0, 4, 0, 4),
				Position = UDim2New(0, 5, 0, 5),
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			})

			Instances:Create("UICorner", {
				Parent = Items["PaletteDragger"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})

			Instances:Create("UIStroke", {
				Parent = Items["PaletteDragger"].Instance,
				Name = "\0",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 1.2000000476837158
			})

			Items["Background"] = Instances:Create("Frame", {
				Parent = Items["ColorpickerWindow"].Instance,
				Name = "\0",
				Size = UDim2New(1, -16, 0, 25),
				Position = UDim2New(0, 8, 1, -8),
				AnchorPoint = Vector2New(0, 1),
				BackgroundColor3 = Library.Theme["Element"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Element'})

			Instances:Create("UIGradient", {
				Parent = Items["Background"].Instance,
				Name = "\0",
				Rotation = 90,
				Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
			})

			Instances:Create("UICorner", {
				Parent = Items["Background"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Input"] = Instances:Create("TextBox", {
				Parent = Items["Background"].Instance,
				Name = "\0",
				Size = UDim2New(1, -16, 1, 0),
				Position = UDim2New(0, 8, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextStrokeColor3 = Library.Theme["Text"],
				PlaceholderText = "Enter RGB..",
				PlaceholderColor3 = Library.Theme["Inactive Text"],
				ClearTextOnFocus = false,
				CursorPosition = -1,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})                
		end

		local AnimationFlag = type(Colorpicker.Flag) == "string" and Colorpicker.Flag ~= "" and (Colorpicker.Flag .. " Animation") or nil

		local AnimDropdown = {
			Value = {},
			Multi = true,
			Callback = function() end,
			Flag = AnimationFlag,
			Options = {},
			MaxSize = 280,
		}

		Items["AnimationsDropdown"] = Instances:Create("Frame", {
			Parent = Items["ColorpickerWindow"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 0, 25),
			Position = UDim2New(0, 8, 1, -38),
			AnchorPoint = Vector2New(0, 1),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ZIndex = 2
		})

		Items["Text"] = Instances:Create("TextLabel", {
			Parent = Items["AnimationsDropdown"].Instance,
			Name = "\0",
			Size = UDim2New(0, 0, 0, 15),
			Position = UDim2New(0, 0, 0.5, 0),
			AnchorPoint = Vector2New(0, 0.5),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "Animations",
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			AutomaticSize = Enum.AutomaticSize.X,
			ZIndex = 2
		}):AddToTheme({TextColor3 = 'Text'})

		Items["RealDropdown"] = Instances:Create("TextButton", {
			Parent = Items["AnimationsDropdown"].Instance,
			Name = "\0",
			Size = UDim2New(0, 125, 0, 25),
			Position = UDim2New(1, 0, 0, 0),
			AnchorPoint = Vector2New(1, 0),
			BackgroundColor3 = Library.Theme["Element"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Element'})

		Instances:Create("UICorner", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIGradient", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			Rotation = 90,
			Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
		})

		Items["Value"] = Instances:Create("TextLabel", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			Size = UDim2New(1, -25, 0, 15),
			Position = UDim2New(0, 8, 0.5, 0),
			AnchorPoint = Vector2New(0, 0.5),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "None",
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 2,
			TextTruncate = Enum.TextTruncate.None
		}):AddToTheme({TextColor3 = 'Text'})

		Instances:Create("UIGradient", {
			Parent = Items["Value"].Instance,
			Name = "\0",
			Transparency = NumSequence{NumSequenceKeypoint(0, 0), NumSequenceKeypoint(0.676, 0), NumSequenceKeypoint(1, 1)}
		})

		Items["Icon"] = Instances:Create("ImageLabel", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			Size = UDim2New(0, 23, 0, 23),
			Position = UDim2New(1, -13, 0.5, 0),
			AnchorPoint = Vector2New(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://126603363478667",
			ImageColor3 = Library.Theme["Text"],
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 2
		})    

		Items["OptionHolder"] = Instances:Create("TextButton", {
			Parent = Library.UnusedHolder.Instance,
			Name = "\0",
			Size = UDim2New(0, 125, 0, 125),
			Position = UDim2New(0, 0, 0, 5),
			AnchorPoint = Vector2New(0, 0),
			BackgroundColor3 = Library.Theme["Background"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			ClipsDescendants = true,
			AutoButtonColor = false,
			ZIndex = 5,
			Visible = false,
			SelectionGroup = true
		}):AddToTheme({BackgroundColor3 = 'Background'})

		Instances:Create("UICorner", {
			Parent = Items["OptionHolder"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIPadding", {
			Parent = Items["OptionHolder"].Instance,
			Name = "\0",
			PaddingLeft = UDimNew(0, 5),
			PaddingRight = UDimNew(0, 5),
			PaddingTop = UDimNew(0, 5),
			PaddingBottom = UDimNew(0, 8)
		})

		Instances:Create("UIListLayout", {
			Parent = Items["OptionHolder"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder
		})

		local Debounce = false 
		local RenderStepped 

		local UIScale = Library.Holder.Instance:FindFirstChildOfClass("UIScale")
		local Scale = UIScale and UIScale.Scale or 1

		function Colorpicker:SetDisabled(Bool)
			Colorpicker.Disabled = Bool

			if Colorpicker.Disabled then 
				Items["ColorpickerButton"]:Tween(nil, {BackgroundTransparency = 0.6})
			else
				Items["ColorpickerButton"]:Tween(nil, {BackgroundTransparency = 0})
			end
		end

		local function UpdateColorpickerPosition()
			if not Library or not Items or not Items["OptionHolder"] or not Items["OptionHolder"].Instance then return end
			if not Items["AnimationsDropdown"] or not Items["AnimationsDropdown"].Instance then return end

			local Scale = Library.UIScaleNum or 1

			local Real = Items["RealDropdown"].Instance
			local Animations = Items["AnimationsDropdown"].Instance

			local PostionX = Real.AbsolutePosition.X
			local SizeX = Real.AbsoluteSize.X
			local PostionY = Animations.AbsolutePosition.Y - 130
			local MaxSize = math.min(AnimDropdown.MaxSize, 125)

			Items["OptionHolder"].Instance.Position = UDim2New(0, PostionX / Scale, 0, PostionY / Scale)
			Items["OptionHolder"].Instance.Size = UDim2New(0, SizeX / Scale, 0, MaxSize / Scale)
		end

		function AnimDropdown:SetOpen(Bool)
			if Debounce then
				return
			end

			AnimDropdown.IsOpen = Bool

			Debounce = true

			if AnimDropdown.IsOpen then
				wait()
				if Items["Icon"] and Items["Icon"].Instance then
					Items["Icon"]:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Rotation = 90,
						ImageColor3 = Library.Theme["Accent"]
					})
				end
			else
				if Items["Icon"] and Items["Icon"].Instance then
					Items["Icon"]:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Rotation = 0,
						ImageColor3 = Library.Theme["Text"]
					})
				end
			end

			if not Items["OptionHolder"] or not Items["OptionHolder"].Instance then
				Debounce = false
				return
			end

			if AnimDropdown.IsOpen then
				Items["OptionHolder"].Instance.Parent = Library.Holder.Instance

				UpdateColorpickerPosition()

				Items["OptionHolder"].Instance.Visible = true

				RenderStepped = RunService.RenderStepped:Connect(function()
					if not Library then return end
					UpdateColorpickerPosition()
				end)

				for Index, Value in Library.OpenFrames do
					if Value ~= AnimDropdown and Value ~= Colorpicker and type(Value.SetOpen) == "function" then
						Value:SetOpen(false)
					end
				end

				Library.OpenFrames[AnimDropdown] = AnimDropdown
			else
				if Library.OpenFrames[AnimDropdown] then
					Library.OpenFrames[AnimDropdown] = nil
				end

				if RenderStepped then
					RenderStepped:Disconnect()
					RenderStepped = nil
				end
			end

			local Descendants = Items["OptionHolder"].Instance:GetDescendants()
			TableInsert(Descendants, Items["OptionHolder"].Instance)

			local NewTween

			for Index, Value in Descendants do 
				local TransparencyProperty = Tween:GetProperty(Value)

				if not TransparencyProperty then
					continue 
				end

				if not Value.ClassName:find("UI") then 
					Value.ZIndex = AnimDropdown.IsOpen and 127 or 1
				end

				if type(TransparencyProperty) == "table" then 
					for _, Property in TransparencyProperty do 
						NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
					end
				else
					NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
				end
			end

			if not NewTween or not NewTween.Tween then
				Debounce = false

				Items["OptionHolder"].Instance.Visible = AnimDropdown.IsOpen
				wait(0.2)
				Items["OptionHolder"].Instance.Parent = not AnimDropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
				return
			end

			NewTween.Tween.Completed:Connect(function()
				Debounce = false

				Items["OptionHolder"].Instance.Visible = AnimDropdown.IsOpen
				wait(0.2)
				Items["OptionHolder"].Instance.Parent = not AnimDropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
			end)
		end

		function AnimDropdown:Add(Option)
			local OptionButton = Instances:Create("TextButton", {
				Parent = Items["OptionHolder"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 25),
				BackgroundColor3 = Library.Theme["Inline"],
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 5
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = OptionButton.Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			local OptionText = Instances:Create("TextLabel", {
				Parent = OptionButton.Instance,
				Name = "\0",
				Size = UDim2New(1, -15, 1, 0),
				Position = UDim2New(0, 4, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Option,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 5
			}):AddToTheme({TextColor3 = 'Text'})                

			local OptionData = {
				Button = OptionButton,
				Name = Option,
				Text = OptionText,
				Selected = false
			}

			function OptionData:Toggle(Value)
				if Value == "Active" then
					OptionData.Text:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 8, 0, 0)})
					OptionData.Button:Tween(nil, {BackgroundTransparency = 0})
				else
					OptionData.Text:Tween(nil, {TextTransparency = 0.4, Position = UDim2New(0, 4, 0, 0)})
					OptionData.Button:Tween(nil, {BackgroundTransparency = 1})
				end
			end

			function OptionData:Set()
				OptionData.Selected = not OptionData.Selected

				if AnimDropdown.Multi then 
					local Index = TableFind(AnimDropdown.Value, OptionData.Name)

					if Index then 
						TableRemove(AnimDropdown.Value, Index)
					else
						TableInsert(AnimDropdown.Value, OptionData.Name)
					end

					OptionData:Toggle(Index and "Inactive" or "Active")

					if type(AnimDropdown.Flag) == "string" and AnimDropdown.Flag ~= "" then
						Library.Flags[AnimDropdown.Flag] = AnimDropdown.Value
					end

					local TextFormat = #AnimDropdown.Value > 0 and TableConcat(AnimDropdown.Value, ", ") or "..."
					Items["Value"].Instance.Text = TextFormat
				else
					if OptionData.Selected then 
						AnimDropdown.Value = OptionData.Name
						if type(AnimDropdown.Flag) == "string" and AnimDropdown.Flag ~= "" then
							Library.Flags[AnimDropdown.Flag] = OptionData.Name
						end

						OptionData.Selected = true
						OptionData:Toggle("Active")

						for Index, Value in AnimDropdown.Options do 
							if Value ~= OptionData then
								Value.Selected = false 
								Value:Toggle("Inactive")
							end
						end

						Items["Value"].Instance.Text = OptionData.Name
					else
						AnimDropdown.Value = nil
						if type(AnimDropdown.Flag) == "string" and AnimDropdown.Flag ~= "" then
							Library.Flags[AnimDropdown.Flag] = nil
						end

						OptionData.Selected = false
						OptionData:Toggle("Inactive")

						Items["Value"].Instance.Text = "..."
					end
				end

				if AnimDropdown.Callback then
					Library:SafeCall(AnimDropdown.Callback, AnimDropdown.Value)
				end
			end

			OptionData.Button:Connect("MouseButton1Down", function()
				OptionData:Set()
			end)

			AnimDropdown.Options[OptionData.Name] = OptionData
			return OptionData
		end

		if IsMobile then
			Items["RealDropdown"]:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.Touch then
					AnimDropdown:SetOpen(not AnimDropdown.IsOpen)
				end
			end)
		else
			Items["RealDropdown"]:Connect("MouseButton1Down", function()
				AnimDropdown:SetOpen(not AnimDropdown.IsOpen)
			end)
		end

		Library:Connect(UserInputService.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if AnimDropdown.IsOpen and Colorpicker.IsOpen then
					if Library:IsMouseOverFrame(Items["OptionHolder"]) then
						return
					end

					AnimDropdown:SetOpen(false)
				end
			end
		end)

		Items["RealDropdown"]:Connect("Changed", function(Property)
			if Property == "AbsolutePosition" and AnimDropdown.IsOpen then
				AnimDropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Data.Section.Items["Section"].Instance.Parent)
				Items["OptionHolder"].Instance.Visible = AnimDropdown.IsOpen
			end
		end)

		AnimDropdown:Add("Rainbow")
		AnimDropdown:Add("Breathing")

		local Debounce = false
		local RenderStepped  

		function Colorpicker:SetOpen(Bool)
			if Debounce then 
				return
			end

			Colorpicker.IsOpen = Bool

			Debounce = true 

			if Colorpicker.IsOpen then 
				wait()
				Items["ColorpickerWindow"].Instance.Visible = true
				Items["ColorpickerWindow"].Instance.Parent = Library.Holder.Instance

				RenderStepped = RunService.RenderStepped:Connect(function()
					local Button = Items["ColorpickerButton"].Instance

					Items["ColorpickerWindow"].Instance.Position = UDim2New(
						0, Button.AbsolutePosition.X,
						0, Button.AbsolutePosition.Y - 280
					)
				end)

				Items["ColorpickerWindow"]:Tween(nil, {Size = UDim2New(0, 218, 0, 275)})

				for Index, Value in Library.OpenFrames do
					if Value ~= Colorpicker and type(Value.SetOpen) == "function" then
						Value:SetOpen(false)
					end
				end

				Library.OpenFrames[Colorpicker] = Colorpicker 
			else
				if Library.OpenFrames[Colorpicker] then
					Library.OpenFrames[Colorpicker] = nil
				end

				if RenderStepped then
					RenderStepped:Disconnect()
					RenderStepped = nil
				end

				if AnimDropdown then
					AnimDropdown:SetOpen(false)
				end

				Items["ColorpickerWindow"]:Tween(nil, {Size = UDim2New(0, 218, 0, 0)})
			end

			local Descendants = Items["ColorpickerWindow"].Instance:GetDescendants()
			TableInsert(Descendants, Items["ColorpickerWindow"].Instance)

			local NewTween

			for Index, Value in Descendants do 
				local TransparencyProperty = Tween:GetProperty(Value)

				if not TransparencyProperty then
					continue 
				end

				if not Value.ClassName:find("UI") then 
					Value.ZIndex = Colorpicker.IsOpen and 125 or 1
					Items["AlphaDragger"].Instance.ZIndex = 126
				end

				if type(TransparencyProperty) == "table" then 
					for _, Property in TransparencyProperty do 
						NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
					end
				else
					NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
				end
			end

			if not NewTween or not NewTween.Tween then
				Debounce = false

				Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
				wait(0.2)
				Items["ColorpickerWindow"].Instance.Parent = not Colorpicker.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
				return
			end

			NewTween.Tween.Completed:Connect(function()
				Debounce = false

				Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
				wait(0.2)
				Items["ColorpickerWindow"].Instance.Parent = not Colorpicker.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
			end)
		end

		function Colorpicker:Get()
			return Colorpicker.Color, Colorpicker.Alpha
		end

		function Colorpicker:Update(IsFromAlpha)
			local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value

			Colorpicker.Color = FromHSV(Hue, Saturation, Value)
			Colorpicker.HexValue = Colorpicker.Color:ToHex()

			if type(Colorpicker.Flag) == "string" and Colorpicker.Flag ~= "" then
				Library.Flags[Colorpicker.Flag] = {
					Alpha = Colorpicker.Alpha,
					Color = Colorpicker.Color,
					HexValue = Colorpicker.HexValue,
					Flag = Colorpicker.Flag,
					Transparency = 1 - Colorpicker.Alpha
				}
			end

			local Color = Colorpicker.Color
			local R, G, B = MathFloor(Color.R * 255), MathFloor(Color.G * 255), MathFloor(Color.B * 255)

			Items["Input"].Instance.Text = R .. ", " .. G .. ", " .. B

			Items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = Color})
			Items["Palette"]:Tween(nil, {BackgroundColor3 = FromHSV(Hue, 1, 1)})

			if not IsFromAlpha then
				Items["Alpha"]:Tween(nil, {BackgroundColor3 = Color})
			end

			if Data.Callback then
				Library:SafeCall(Data.Callback, Color, Colorpicker.Alpha)
			end

			Library:SaveAutoloadIfEnabled()
		end

		local SlidingPalette = false
		local PaletteChanged

		function Colorpicker:SlidePalette(Input)
			if not Input or not SlidingPalette then
				return
			end

			local PaletteInst = Items["Palette"].Instance
			local PaletteSize = PaletteInst.AbsoluteSize
			local PalettePos = PaletteInst.AbsolutePosition

			local SlideX = (Input.Position.X - PalettePos.X) / PaletteSize.X
			local SlideY = (Input.Position.Y - PalettePos.Y) / PaletteSize.Y

			local ValueX = MathClamp(1 - SlideX, 0, 1)
			local ValueY = MathClamp(1 - SlideY, 0, 1)

			Colorpicker.Saturation = ValueX
			Colorpicker.Value = ValueY

			Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2New(MathClamp(SlideX, 0, 0.98), 0, MathClamp(SlideY, 0, 0.98), 0)
			})
			Colorpicker:Update()
		end

		local SlidingHue = false
		local HueChanged

		function Colorpicker:SlideHue(Input)
			if not Input or not SlidingHue then
				return
			end

			local HueInst = Items["Hue"].Instance
			local HueSize = HueInst.AbsoluteSize
			local HuePos = HueInst.AbsolutePosition
			local SlideX = (Input.Position.X - HuePos.X) / HueSize.X

			Colorpicker.Hue = MathClamp(SlideX, 0, 1)

			Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2New(MathClamp(SlideX, 0, 0.985), 0, 0.5, 0)
			})
			Colorpicker:Update()
		end

		local SlidingAlpha = false
		local AlphaChanged

		function Colorpicker:SlideAlpha(Input)
			if not Input or not SlidingAlpha then
				return
			end

			local AlphaInst = Items["Alpha"].Instance
			local AlphaSize = AlphaInst.AbsoluteSize
			local AlphaPos = AlphaInst.AbsolutePosition
			local SlideY = (Input.Position.Y - AlphaPos.Y) / AlphaSize.Y

			Colorpicker.Alpha = MathClamp(SlideY, 0, 1)

			Items["AlphaDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2New(0.5, 0, MathClamp(SlideY, 0, 0.98), 0)
			})

			Colorpicker:Update(true)
		end

		function Colorpicker:Set(Color, Alpha)
			if type(Color) == "table" then
				Color = FromRGB(Color[1], Color[2], Color[3])
			elseif type(Color) == "string" then
				Color = FromHex(Color)
			end

			Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
			Colorpicker.Alpha = Alpha or 0

			local PaletteValueX = MathClamp(1 - Colorpicker.Saturation, 0, 0.985)
			local PaletteValueY = MathClamp(1 - Colorpicker.Value, 0, 0.985)
			local AlphaPositionY = MathClamp(Colorpicker.Alpha, 0, 0.99)
			local HuePositionX = MathClamp(Colorpicker.Hue, 0, 0.98)

			Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2New(PaletteValueX, 0, PaletteValueY, 0)
			})
			Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2New(HuePositionX, 0, 0.5, 0)
			})
			Items["AlphaDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2New(0.5, 0, AlphaPositionY, 0)
			})

			Colorpicker:Update()
		end

		AnimDropdown.Callback = function(Value)
			local HasRainbow = TableFind(Value, "Rainbow")
			local HasBreathing = TableFind(Value, "Breathing")

			if HasRainbow then
				local SavedColor = Colorpicker.Color

				Library:Thread(LPH_NO_VIRTUALIZE(function()
					while wait(0.07) do
						local RainbowHue = MathAbs(MathSin(tick() * 0.33))
						Colorpicker:Set(FromHSV(RainbowHue, 1, 1), Colorpicker.Alpha)

						if not TableFind(AnimDropdown.Value, "Rainbow") then
							Colorpicker:Set(SavedColor, Colorpicker.Alpha)
							break
						end
					end
				end))
			end

			if HasBreathing then
				local SavedAlpha = Colorpicker.Alpha

				Library:Thread(LPH_NO_VIRTUALIZE(function()
					while wait(0.07) do
						local AlphaValue = MathAbs(MathSin(tick() * 0.8))
						Colorpicker:Set(Colorpicker.Color, AlphaValue)

						if not TableFind(AnimDropdown.Value, "Breathing") then
							Colorpicker:Set(Colorpicker.Color, SavedAlpha)
							break
						end
					end
				end))
			end
		end

		Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
			if Colorpicker.Disabled then 
				return 
			end

			Colorpicker:SetOpen(not Colorpicker.IsOpen)
		end)

		Items["Palette"]:Connect("InputBegan", function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Colorpicker.Disabled then
					return
				end

				SlidingPalette = true

				Colorpicker:SlidePalette(Input)

				if PaletteChanged then
					return
				end

				PaletteChanged = Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						SlidingPalette = false

						PaletteChanged:Disconnect()
						PaletteChanged = nil
					end
				end)
			end
		end)

		Items["Hue"]:Connect("InputBegan", function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Colorpicker.Disabled then
					return
				end

				SlidingHue = true

				Colorpicker:SlideHue(Input)

				if HueChanged then
					return
				end

				HueChanged = Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						SlidingHue = false

						HueChanged:Disconnect()
						HueChanged = nil
					end
				end)
			end
		end)

		Items["Alpha"]:Connect("InputBegan", function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Colorpicker.Disabled then
					return
				end

				SlidingAlpha = true

				Colorpicker:SlideAlpha(Input)

				if AlphaChanged then
					return
				end

				AlphaChanged = Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						SlidingAlpha = false

						AlphaChanged:Disconnect()
						AlphaChanged = nil
					end
				end)
			end
		end)

		Items["Input"]:Connect("FocusLost", function()
			if Colorpicker.Disabled then
				return
			end

			local Text  = Items["Input"].Instance.Text
			local R, G, B = Text:match("(%d+),%s*(%d+),%s*(%d+)")

			R, G, B = tonumber(R), tonumber(G), tonumber(B)
			Colorpicker:Set(FromRGB(R, G, B), Colorpicker.Alpha)
		end)

		Library:Connect(UserInputService.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				if Colorpicker.Disabled then
					return
				end

				if SlidingPalette then
					Colorpicker:SlidePalette(Input)
				end

				if SlidingHue then
					Colorpicker:SlideHue(Input)
				end

				if SlidingAlpha then
					Colorpicker:SlideAlpha(Input)
				end
			end
		end)

		Library:Connect(UserInputService.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Colorpicker.Disabled then
					return
				end

				if not Colorpicker.IsOpen then
					return
				end

				if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) or Library:IsMouseOverFrame(Items["OptionHolder"]) then
					return
				end

				Colorpicker:SetOpen(false)
			end
		end)

		if Data.Default then
			Colorpicker:Set(Data.Default, Data.Alpha)
		end

		Library:BindElementFlag(Colorpicker.Flag, function(Value, Alpha)
			if Colorpicker.Disabled then
				return
			end

			Colorpicker:Set(Value, Alpha)
		end)

		if type(Colorpicker.Flag) == "string" and Colorpicker.Flag ~= "" and type(Data.Callback) == "function" then
			Library:RegisterConfigFlagCallback(Colorpicker.Flag, function()
				if Colorpicker.Disabled == true then
					return
				end
				Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
			end)
		end

		if type(AnimDropdown.Flag) == "string" and AnimDropdown.Flag ~= "" then
			Library.SetFlags[AnimDropdown.Flag] = function(Value)
				if type(Value) == "string" then
					Value = { Value }
				end

				if type(Value) ~= "table" then
					Value = {}
				end

				AnimDropdown.Value = Value
				Library.Flags[AnimDropdown.Flag] = AnimDropdown.Value

				local TextFormat = #AnimDropdown.Value > 0 and TableConcat(AnimDropdown.Value, ", ") or "..."
				Items["Value"].Instance.Text = TextFormat

				for OptName, OptionData in AnimDropdown.Options do
					local Selected = TableFind(AnimDropdown.Value, OptName)

					OptionData.Selected = Selected ~= nil
					OptionData:Toggle(Selected and "Active" or "Inactive")
				end

				if AnimDropdown.Callback then
					Library:SafeCall(AnimDropdown.Callback, AnimDropdown.Value)
				end
			end
		end

		function Colorpicker:Destroy()
			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			return Colorpicker
		end

		return Colorpicker, Items 
	end

	Library.CreateKeybind = function(self, Data)
		local Keybind = {
			Flag = Data.Flag,

			Value = "",
			Key  = "",
			Mode = "",

			Toggled = false,
			Disabled = false,
			Picking = false,

			IsOpen = false 
		}

		local Items = {} do 
			Items["KeyButton"] = Instances:Create("TextButton", {
				Parent = Data.Parent.Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 20),
				Position = UDim2New(1, 0, 0, 0),
				AnchorPoint = Vector2New(1, 0),
				BackgroundColor3 = Library.Theme["Background"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "None",
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				AutomaticSize = Enum.AutomaticSize.X,
				AutoButtonColor = false,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Background'})

			Instances:Create("UIPadding", {
				Parent = Items["KeyButton"].Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, 5),
				PaddingRight = UDimNew(0, 5)
			})

			Instances:Create("UICorner", {
				Parent = Items["KeyButton"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})                

			Items["KeybindWindow"] = Instances:Create("Frame", {
				Parent = Library.UnusedHolder.Instance,
				Name = "\0",
				Size = UDim2New(0, 100, 0, 100),
				Position = UDim2New(0.005164622329175472, 0, 0.34007585048675537, 0),
				BackgroundColor3 = Library.Theme["Background"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Visible = false
			}):AddToTheme({BackgroundColor3 = 'Background'})

			Instances:Create("UICorner", {
				Parent = Items["KeybindWindow"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Shadow"] = Instances:Create("ImageLabel", {
				Parent = Items["KeybindWindow"].Instance,
				Name = "\0",
				Size = UDim2New(1, 55, 1, 55),
				Position = UDim2New(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2New(0.5, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://112971167999062",
				ImageColor3 = FromRGB(0, 0, 0),
				ImageTransparency = 0.5600000023841858,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = RectNew(Vector2New(112, 112), Vector2New(147, 147)),
				SliceScale = 0.6000000238418579,
				ZIndex = -1
			}):AddToTheme({ImageColor3 = 'Shadow'})

			Items["Toggle"] = Instances:Create("TextButton", {
				Parent = Items["KeybindWindow"].Instance,
				Name = "\0",
				Size = UDim2New(1, -16, 0, 25),
				Position = UDim2New(0, 8, 0, 8),
				BackgroundColor3 = Library.Theme["Inline"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["ToggleText"] = Instances:Create("TextLabel", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				Size = UDim2New(1, -15, 1, 0),
				Position = UDim2New(0, 8, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "Toggle",
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})

			Items["Hold"] = Instances:Create("TextButton", {
				Parent = Items["KeybindWindow"].Instance,
				Name = "\0",
				Size = UDim2New(1, -16, 0, 25),
				Position = UDim2New(0, 8, 0, 33),
				BackgroundColor3 = Library.Theme["Inline"],
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = Items["Hold"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["HoldText"] = Instances:Create("TextLabel", {
				Parent = Items["Hold"].Instance,
				Name = "\0",
				Size = UDim2New(1, -15, 1, 0),
				Position = UDim2New(0, 4, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "Hold",
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})

			Items["Always"] = Instances:Create("TextButton", {
				Parent = Items["KeybindWindow"].Instance,
				Name = "\0",
				Size = UDim2New(1, -16, 0, 25),
				Position = UDim2New(0, 8, 0, 58),
				BackgroundColor3 = Library.Theme["Inline"],
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = Items["Always"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["AlwaysText"] = Instances:Create("TextLabel", {
				Parent = Items["Always"].Instance,
				Name = "\0",
				Size = UDim2New(1, -15, 1, 0),
				Position = UDim2New(0, 4, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "Always",
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})                
		end

		Keybind.Mode = Data.Mode or "Toggle"
		Keybind.DisplayName = Data.Name or Data.name or "Keybind"

		local KeyListItem

		local function SyncKeyListItem()
			if not KeyListItem and Library.KeyList then
				KeyListItem = Library.KeyList:Add(Keybind.Value or "", Keybind.DisplayName, Keybind.Mode or "Toggle")
			end

			if KeyListItem then
				KeyListItem:Set(Keybind.Value or "None", Keybind.DisplayName, Keybind.Mode or "Toggle")
				KeyListItem:SetStatus(Keybind.Toggled)
			end
		end

		local Update = function()
			SyncKeyListItem()
		end

		local KeybindEntry = {
			Keybind = Keybind,
			Update = Update,
			KeyListItem = KeyListItem,
		}

		TableInsert(Library.KeybindEntries, KeybindEntry)

		if Library.KeyList then
			SyncKeyListItem()
			KeybindEntry.KeyListItem = KeyListItem
		end

		local Modes = {
			["Toggle"] = {Items["Toggle"], Items["ToggleText"]},
			["Hold"] = {Items["Hold"], Items["HoldText"]},
			["Always"] = {Items["Always"], Items["AlwaysText"]}
		}

		local Debounce = false
		local RenderStepped  

		function Keybind:SetDisabled(Bool)
			Keybind.Disabled = Bool 

			if Keybind.Disabled then 
				Items["KeyButton"]:Tween(nil, {BackgroundTransparency = 0.6, TextTransparency = 0.6})
			else
				Items["KeyButton"]:Tween(nil, {BackgroundTransparency = 0, TextTransparency = 0})
			end
		end

		function Keybind:SetOpen(Bool)
			if Debounce then 
				return
			end

			Keybind.IsOpen = Bool

			Debounce = true 

			if Keybind.IsOpen then 
				wait()
				Items["KeybindWindow"].Instance.Visible = true
				Items["KeybindWindow"].Instance.Parent = Library.Holder.Instance

				RenderStepped = RunService.RenderStepped:Connect(function()
					local Button = Items["KeyButton"].Instance

					Items["KeybindWindow"].Instance.Position = UDim2New(
						0, Button.AbsolutePosition.X,
						0, Button.AbsolutePosition.Y + Button.AbsoluteSize.Y + 5
					)
				end)

				for Index, Value in Library.OpenFrames do
					if Value ~= Keybind and type(Value.SetOpen) == "function" then
						Value:SetOpen(false)
					end
				end

				Library.OpenFrames[Keybind] = Keybind 
			else
				if Library.OpenFrames[Keybind] then 
					Library.OpenFrames[Keybind] = nil
				end

				if RenderStepped then 
					RenderStepped:Disconnect()
					RenderStepped = nil
				end
			end

			local Descendants = Items["KeybindWindow"].Instance:GetDescendants()
			TableInsert(Descendants, Items["KeybindWindow"].Instance)

			local NewTween

			for Index, Value in Descendants do 
				local TransparencyProperty = Tween:GetProperty(Value)

				if not TransparencyProperty then
					continue 
				end

				if not Value.ClassName:find("UI") then 
					Value.ZIndex = Keybind.IsOpen and 4 or 1
				end

				if type(TransparencyProperty) == "table" then 
					for _, Property in TransparencyProperty do 
						NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
					end
				else
					NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
				end
			end

			if not NewTween or not NewTween.Tween then
				Debounce = false

				Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
				wait(0.2)
				Items["KeybindWindow"].Instance.Parent = not Keybind.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
				return
			end

			NewTween.Tween.Completed:Connect(function()
				Debounce = false

				Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
				wait(0.2)
				Items["KeybindWindow"].Instance.Parent = not Keybind.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
			end)
		end

		function Keybind:SetMode(Mode)
			for Index, Value in Modes do 
				if Index == Mode then 
					Value[1]:Tween(nil, {BackgroundTransparency = 0})
					Value[2]:Tween(nil, {TextTransparency = 0})
				else
					Value[1]:Tween(nil, {BackgroundTransparency = 1})
					Value[2]:Tween(nil, {TextTransparency = 0.4})
				end
			end

			Library.Flags[Keybind.Flag] = {
				Mode = Keybind.Mode,
				Key = Keybind.Key,
				Toggled = Keybind.Toggled
			}

			if Data.Callback then 
				Library:SafeCall(Data.Callback, Keybind.Toggled)
			end

			Update()
		end

		function Keybind:Press(Bool)
			if Keybind.Mode == "Toggle" then 
				Keybind.Toggled = not Keybind.Toggled
			elseif Keybind.Mode == "Hold" then 
				Keybind.Toggled = Bool
			elseif Keybind.Mode == "Always" then 
				Keybind.Toggled = true
			end

			Library.Flags[Keybind.Flag] = {
				Mode = Keybind.Mode,
				Key = Keybind.Key,
				Toggled = Keybind.Toggled
			}

			if Data.Callback then 
				Library:SafeCall(Data.Callback, Keybind.Toggled)
			end

			Update()
		end

		function Keybind:Get()
			return Keybind.Key, Keybind.Mode, Keybind.Toggled
		end

		function Keybind:Set(Key)
			if StringFind(tostring(Key), "Enum") then 
				if is_keybind_none_key(Key) then
					Keybind.Key = tostring(KEYBIND_NONE_KEY)
					Keybind.Value = "None"
					Items["KeyButton"].Instance.Text = "None"
				else
					Keybind.Key = tostring(Key)
					Keybind.Value = get_keybind_display_text(Key, Keybind.Key)
					Items["KeyButton"].Instance.Text = Keybind.Value
				end

				Library.Flags[Keybind.Flag] = {
					Mode = Keybind.Mode,
					Key = Keybind.Key,
					Toggled = Keybind.Toggled
				}

				if Data.Callback then 
					Library:SafeCall(Data.Callback, Keybind.Toggled)
				end

				Update()
			elseif type(Key) == "table" then
				local bound_key = Key.Key

				if Key.Mode then
					Keybind.Mode = Key.Mode
					Keybind:SetMode(Key.Mode)
				else
					Keybind.Mode = "Toggle"
					Keybind:SetMode("Toggle")
				end

				if is_keybind_none_key(bound_key) then
					Keybind.Key = tostring(KEYBIND_NONE_KEY)
					Keybind.Value = "None"
					Items["KeyButton"].Instance.Text = "None"
				else
					Keybind.Key = tostring(bound_key)
					Keybind.Value = get_keybind_display_text(bound_key, Keybind.Key)
					Items["KeyButton"].Instance.Text = Keybind.Value
				end

				Library.Flags[Keybind.Flag] = {
					Mode = Keybind.Mode,
					Key = Keybind.Key,
					Toggled = Keybind.Toggled
				}

				if Data.Callback then 
					Library:SafeCall(Data.Callback, Keybind.Toggled)
				end

				Update()
			elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
				Keybind.Mode = Key
				Keybind:SetMode(Key)

				if Data.Callback then 
					Library:SafeCall(Data.Callback, Keybind.Toggled)
				end

				Update()
			end

			Keybind.Picking = false
			Library:SaveAutoloadIfEnabled()
		end

		Items["KeyButton"]:Connect("MouseButton1Click", function()
			if Keybind.Disabled then 
				return 
			end

			Keybind.Picking = true 

			Items["KeyButton"].Instance.Text = "press a key"

			local InputBegan

			InputBegan = UserInputService.InputBegan:Connect(function(Input)

				if Input.UserInputType == Enum.UserInputType.Keyboard then 
					Keybind:Set(Input.KeyCode)
				else
					Keybind:Set(Input.UserInputType)
				end

				InputBegan:Disconnect()
				InputBegan = nil
			end)
		end)

		Library:Connect(UserInputService.InputBegan, function(Input, Gpe)
			if Keybind.Disabled then
				return
			end

			if Keybind.Value == "None" then
				return
			end

			if not Gpe then
				if tostring(Input.KeyCode) == Keybind.Key then
					if Keybind.Mode == "Toggle" then
						Keybind:Press()
					elseif Keybind.Mode == "Hold" then
						Keybind:Press(true)
					elseif Keybind.Mode == "Always" then
						Keybind:Press(true)
					end
				elseif tostring(Input.UserInputType) == Keybind.Key then
					if Keybind.Mode == "Toggle" then
						Keybind:Press()
					elseif Keybind.Mode == "Hold" then
						Keybind:Press(true)
					elseif Keybind.Mode == "Always" then
						Keybind:Press(true)
					end
				end
			end

			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if not Keybind.IsOpen then
					return
				end

				if Library:IsMouseOverFrame(Items["KeybindWindow"]) then
					return
				end

				Keybind:SetOpen(false)
			end
		end)

		Library:Connect(UserInputService.InputEnded, function(Input, Gpe)
			if Keybind.Disabled then
				return
			end

			if Gpe then
				return
			end

			if Keybind.Value == "None" then
				return
			end

			if tostring(Input.KeyCode) == Keybind.Key then
				if Keybind.Mode == "Hold" then
					Keybind:Press(false)
				elseif Keybind.Mode == "Always" then
					Keybind:Press(true)
				end
			elseif tostring(Input.UserInputType) == Keybind.Key then
				if Keybind.Mode == "Hold" then
					Keybind:Press(false)
				elseif Keybind.Mode == "Always" then
					Keybind:Press(true)
				end
			end
		end)

		Items["KeyButton"]:Connect("MouseButton2Down", function()
			if Keybind.Disabled then 
				return 
			end

			Keybind:SetOpen(not Keybind.IsOpen)
		end)

		Items["Toggle"]:Connect("MouseButton1Down", function()
			Keybind.Mode = "Toggle"
			Keybind.Toggled = false
			Keybind:SetMode("Toggle")
		end)

		Items["Hold"]:Connect("MouseButton1Down", function()
			Keybind.Mode = "Hold"
			Keybind.Toggled = false
			Keybind:SetMode("Hold")
		end)

		Items["Always"]:Connect("MouseButton1Down", function()
			Keybind.Mode = "Always"
			Keybind.Toggled = true
			Keybind:SetMode("Always")
		end)

		Keybind:Set({
			Mode = Data.Mode or "Toggle",
			Key = Data.Default or KEYBIND_NONE_KEY,
		})

		Library:BindElementFlag(Keybind.Flag, function(Value)
			if Keybind.Disabled then
				return
			end
			Keybind:Set(Value)
		end)

		function Keybind:Destroy()
			for Index, Entry in Library.KeybindEntries do
				if Entry.Keybind == Keybind then
					if Entry.KeyListItem and Entry.KeyListItem.Instance then
						Entry.KeyListItem.Instance:Destroy()
					end
					TableRemove(Library.KeybindEntries, Index)
					break
				end
			end

			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			if Library.KeyList then
				Library.KeyList:Resize()
			end

			return Keybind
		end

		return Keybind, Items 
	end

	Library.Watermark = function(self, NameOrOptions)
		local Data = type(NameOrOptions) == "table" and NameOrOptions or { Name = NameOrOptions }
		local BrandName = Data.Name or Data.name or "Solix Hub"
		local Dynamic = Data.Dynamic == true
		local DynamicOptions = Data.Options or Data.options or { "fps", "ping", "time" }

		local StatsService = cloneref(game:GetService("Stats"))
		local WatermarkPath = GetFolders().Datas .. "/watermark.json"

		local function ColorToRgbStr(Color)
			return string.format(
				"rgb(%d,%d,%d)",
				MathFloor(Color.R * 255 + 0.5),
				MathFloor(Color.G * 255 + 0.5),
				MathFloor(Color.B * 255 + 0.5)
			)
		end

		local function FormatBrandRichText(Text)
			if not Text or Text == "" then
				return ""
			end

			if string.find(Text, "<font", 1, true) then
				return Text
			end

			local Lower = string.lower(Text)
			local HubIndex = string.find(Lower, "hub", 1, true)

			if HubIndex then
				local AccentColor = ColorToRgbStr(Library.Theme["Accent"])
				local Before = Text:sub(1, HubIndex - 1)
				local HubPart = Text:sub(HubIndex, HubIndex + 2)
				local After = Text:sub(HubIndex + 3)

				return Before .. `<font color="{AccentColor}">` .. HubPart .. "</font>" .. After
			end

			return Text
		end

		local function GetTime12h()
			local Time = os.date("*t")
			local Hour = Time.hour % 12

			if Hour == 0 then
				Hour = 12
			end

			return string.format("%d:%02d %s", Hour, Time.min, Time.hour >= 12 and "PM" or "AM")
		end

		local function GetPing()
			local Success, Ping = pcall(function()
				return StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
			end)

			if Success and Ping then
				return MathFloor(Ping)
			end

			Success, Ping = pcall(function()
				return StatsService.PerformanceStats.Ping:GetValue()
			end)

			if Success and Ping then
				return MathFloor(Ping)
			end

			return 0
		end

		local Watermark = {
			CustomText = nil,
			Dynamic = Dynamic,
			DynamicOptions = DynamicOptions,
			BrandName = BrandName,
			IsVisible = false,
		}

		local Items = {} do
			Items["WatermarkGui"] = Instances:Create("ScreenGui", {
				Parent = SafeGetUI(),
				Name = "\0",
				Enabled = true,
				DisplayOrder = Library.DisplayOrders.FloatingButtonOpen,
				IgnoreGuiInset = true,
				ResetOnSpawn = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Global,
			})

			Items["Frame"] = Instances:Create("Frame", {
				Parent = Items["WatermarkGui"].Instance,
				Name = "\0",
				Position = UDim2New(0, 5, 0, 5),
				Size = UDim2New(0, 0, 0, 25),
				BackgroundColor3 = FromRGB(27, 26, 26),
				BorderSizePixel = 0,
				BorderColor3 = FromRGB(0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.X,
			})

			local StrokeLayers = {
				{ Color = FromRGB(33, 32, 32), Thickness = 4 },
				{ Color = FromRGB(42, 42, 42), Thickness = 2 },
				{ Color = FromRGB(36, 36, 36), Thickness = 3 },
				{ Color = FromRGB(42, 42, 42), Thickness = 1 },
			}

			for _, StrokeData in ipairs(StrokeLayers) do
				Instances:Create("UIStroke", {
					Parent = Items["Frame"].Instance,
					Name = "\0",
					Color = StrokeData.Color,
					Thickness = StrokeData.Thickness,
					LineJoinMode = Enum.LineJoinMode.Miter,
				})
			end

			Instances:Create("UIPadding", {
				Parent = Items["Frame"].Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, 4),
				PaddingRight = UDimNew(0, 4),
			})

			Items["Label"] = Instances:Create("TextLabel", {
				Parent = Items["Frame"].Instance,
				Name = "\0",
				Position = UDim2New(0, 0, 0.5, 0),
				Size = UDim2New(0, 0, 1, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				BorderColor3 = FromRGB(0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.X,
				Text = "",
				TextColor3 = FromRGB(255, 255, 255),
				TextSize = 12,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				RichText = true,
			})

			Items["AccentBar"] = Instances:Create("Frame", {
				Parent = Items["Frame"].Instance,
				Name = "\0",
				Position = UDim2New(0.5, 0, 0, 0),
				Size = UDim2New(1, 8, 0, 2),
				AnchorPoint = Vector2New(0.5, 0),
				BackgroundColor3 = Library.Theme["Accent"],
				BorderSizePixel = 0,
				BorderColor3 = FromRGB(0, 0, 0),
			})

			Instances:Create("UIGradient", {
				Parent = Items["AccentBar"].Instance,
				Name = "\0",
				Rotation = 90,
				Transparency = NumSequence{
					NumSequenceKeypoint(0, 0),
					NumSequenceKeypoint(0.394015, 0),
					NumSequenceKeypoint(1, 1),
				},
			})

			Items["Frame"]:MakeDraggable()
		end

		local TargetFPS, TargetPing = 0, 0
		local DisplayFPS, DisplayPing = 0, 0
		local LastSample = os.clock()
		local LastSave = os.clock()

		local RenderFuncs = {
			fps = function()
				return `{MathFloor(DisplayFPS)} fps`
			end,
			ping = function()
				return `{MathFloor(DisplayPing)} ms`
			end,
			time = function()
				return GetTime12h()
			end,
		}

		local function SavePosition()
			if not writefile then
				return
			end

			pcall(function()
				local Frame = Items["Frame"].Instance
				writefile(WatermarkPath, HttpService:JSONEncode({
					X = Frame.Position.X.Offset,
					Y = Frame.Position.Y.Offset,
				}))
			end)
		end

		local function LoadPosition()
			if not readfile or not isfile or not isfile(WatermarkPath) then
				return
			end

			pcall(function()
				local Saved = HttpService:JSONDecode(readfile(WatermarkPath))
				Items["Frame"].Instance.Position = UDim2New(0, Saved.X or 5, 0, Saved.Y or 5)
			end)
		end

		local function BuildDynamicSuffix()
			local Parts = {}

			for _, OptionName in ipairs(Watermark.DynamicOptions) do
				local Render = RenderFuncs[OptionName]

				if Render then
					TableInsert(Parts, Render())
				end
			end

			if #Parts == 0 then
				return ""
			end

			return " | " .. table.concat(Parts, " | ")
		end

		local function RefreshLabel()
			local BaseText = Watermark.CustomText or FormatBrandRichText(Watermark.BrandName)

			if Watermark.CustomText and not string.find(Watermark.CustomText, "<font", 1, true) then
				BaseText = FormatBrandRichText(Watermark.CustomText)
			end

			if Watermark.Dynamic then
				Items["Label"].Instance.Text = BaseText .. BuildDynamicSuffix()
			else
				Items["Label"].Instance.Text = BaseText
			end

			Items["AccentBar"].Instance.BackgroundColor3 = Library.Theme["Accent"]
		end

		function Watermark:SetText(Text)
			Watermark.CustomText = Text and tostring(Text) or nil
			RefreshLabel()
		end

		local function ClampWatermarkPosition()
			local Frame = Items["Frame"] and Items["Frame"].Instance
			local Camera = Workspace.CurrentCamera

			if not Frame or not Camera then
				return
			end

			local Viewport = Camera.ViewportSize
			local Size = Frame.AbsoluteSize
			local Position = Frame.Position
			local X = Position.X.Offset
			local Y = Position.Y.Offset

			if Size.X <= 0 or Size.Y <= 0 then
				Frame.Position = UDim2FromOffset(5, 5)
				return
			end

			if X < -Size.X or X > Viewport.X or Y < -Size.Y or Y > Viewport.Y then
				Frame.Position = UDim2FromOffset(5, 5)
				SavePosition()
			end
		end

		function Watermark:SetVisibility(Bool)
			local Visible = Bool == true
			Watermark.IsVisible = Visible

			if Items["WatermarkGui"] and Items["WatermarkGui"].Instance then
				Items["WatermarkGui"].Instance.Enabled = Visible
			end

			if Items["Frame"] and Items["Frame"].Instance then
				Items["Frame"].Instance.Visible = Visible

				if Visible then
					ClampWatermarkPosition()
					RefreshLabel()
				end
			end
		end

		function Watermark:SetDynamic(Enabled, Options)
			Watermark.Dynamic = Enabled == true

			if Options then
				Watermark.DynamicOptions = Options
			end

			RefreshLabel()
		end

		function Watermark:SetCenter()
			local CenterPosition = Items["Frame"].Instance.AbsolutePosition

			wait()

			Items["Frame"].Instance.AnchorPoint = Vector2New(0, 0)
			Items["Frame"].Instance.Position = UDim2New(0, CenterPosition.X, 0, CenterPosition.Y)
			SavePosition()
		end

		LoadPosition()
		RefreshLabel()
		Watermark:SetCenter()
		Watermark:SetVisibility(self.ShowWatermark == true)

		Library:Connect(RunService.RenderStepped, function(DeltaTime)
			if not Items["Frame"].Instance.Visible then
				return
			end

			if os.clock() - LastSample > 0.25 then
				LastSample = os.clock()
				TargetFPS = MathFloor(1 / math.max(DeltaTime, 1e-6))
				TargetPing = GetPing()
			end

			local LerpAlpha = math.min(1, DeltaTime * 8)
			DisplayFPS = DisplayFPS + (TargetFPS - DisplayFPS) * LerpAlpha
			DisplayPing = DisplayPing + (TargetPing - DisplayPing) * LerpAlpha

			if Watermark.Dynamic then
				RefreshLabel()
			end

			if os.clock() - LastSave > 0.85 then
				LastSave = os.clock()
				SavePosition()
			end
		end)

		Library.WatermarkGui = Items["WatermarkGui"]
		Library.WatermarkInstance = Watermark
		self:ApplyFontSettings()

		return Watermark
	end

	Library.KeybindList = function(self, Name)
		Name = Name or "Keybinds"

		local KeybindList = {}

		Library.KeyList = KeybindList

		local Items = {} do 
			Items["KeybindList"] = Instances:Create("Frame", {
				Parent = Library.Holder.Instance,
				Name = "\0",
				Position = UDim2New(0.005164622329175472, 0, 0.4690265357494354, 0),
				BackgroundColor3 = Library.Theme["Background"],
				BackgroundTransparency = 0.30000001192092896,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.None
			}):AddToTheme({BackgroundColor3 = 'Background'})

			Items["KeybindList"]:MakeDraggable()

			Instances:Create("UICorner", {
				Parent = Items["KeybindList"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Text"] = Instances:Create("TextLabel", {
				Parent = Items["KeybindList"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 15),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "Keybinds",
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				AutomaticSize = Enum.AutomaticSize.X
			}):AddToTheme({TextColor3 = 'Text'})

			Instances:Create("UIPadding", {
				Parent = Items["KeybindList"].Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, 8),
				PaddingRight = UDimNew(0, 8),
				PaddingTop = UDimNew(0, 8),
				PaddingBottom = UDimNew(0, 8)
			})

			Items["Content"] = Instances:Create("Frame", {
				Parent = Items["KeybindList"].Instance,
				Name = "\0",
				Position = UDim2New(0, 8, 0, 20),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY
			})

			Instances:Create("UIListLayout", {
				Parent = Items["Content"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder
			})                
		end

		local VisibleItems = {}

		function KeybindList:SetTransparency()
			Items["KeybindList"].Instance.BackgroundTransparency = Library.BackgroundTransparency
		end

		function KeybindList:SetText(Text)
			Items["Text"].Instance.Text = tostring(Text)
		end

		function KeybindList:SetVisibility(Bool)
			Items["KeybindList"].Instance.Visible = Bool 
		end

		function KeybindList:SetCenter()
			local CenterPosition = Items["KeybindList"].Instance.AbsolutePosition

			Items["KeybindList"].Instance.AnchorPoint = Vector2New(0, 0)
			Items["KeybindList"].Instance.Position = UDim2New(0, CenterPosition.X, 0, CenterPosition.Y)
		end

		function KeybindList:Resize()
			local SizeY = 0
			local SizeX = 0

			table.clear(VisibleItems)

			for Index, Value in Items["Content"].Instance:GetChildren() do 
				if Value.ClassName:find("UI") then continue end
				if not Value.Visible then continue end

				SizeY = SizeY + Value.AbsoluteSize.Y + 5
				SizeX = math.max(SizeX, Value.AbsoluteSize.X)

				table.insert(VisibleItems, Value)
			end

			if #VisibleItems == 0 then 
				SizeX = Items["Text"].Instance.TextBounds.X + 14
				SizeY = 32

				Items["KeybindList"]:Tween(nil, {Size = UDim2New(0, SizeX, 0, SizeY)})
				return 
			end

			Items["KeybindList"]:Tween(nil, {Size = UDim2New(0, SizeX + 30, 0, SizeY + 30)})
		end

		function KeybindList:Add(Key, Name, Mode)
			local NewKey = Instances:Create("TextLabel", {
				Parent = Items["Content"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 20),
				BackgroundColor3 = FromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = ""..Key.." - ".. Name .. " (".. Mode .. ")",
				TextColor3 = Library.Theme['Text'],
				TextSize = 14,
				FontFace = Library.Font,
				AutomaticSize = Enum.AutomaticSize.X
			})  NewKey:AddToTheme({TextColor3 = "Text"})

			Instances:Create("UIPadding", {
				Parent = NewKey.Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, 0),
				PaddingRight = UDimNew(0, 0)
			})

			function NewKey:Set(Key, Name, Mode)
				NewKey.Instance.Text = ""..Key.." - ".. Name .. " (".. Mode .. ")"
				KeybindList:Resize()
			end

			function NewKey:SetStatus(Bool)
				if Bool then 
					NewKey:ChangeItemTheme({TextColor3 = "Accent"})
					NewKey:Tween(nil, {TextColor3 = Library.Theme.Accent})
				else
					NewKey:ChangeItemTheme({TextColor3 = "Text"})
					NewKey:Tween(nil, {TextColor3 = Library.Theme.Text})
				end
			end

			KeybindList:Resize()
			return NewKey
		end

		function KeybindList:SyncEntries()
			for _, Entry in Library.KeybindEntries do
				if Entry.Update then
					if not Entry.KeyListItem and Library.KeyList then
						Entry.KeyListItem = KeybindList:Add("", "", "")
					end
					Entry.Update()
				end
			end

			KeybindList:Resize()
		end

		KeybindList:SetText(Name)
		KeybindList:SetCenter()
		KeybindList:SyncEntries()
		KeybindList:SetVisibility(self.ShowKeybindList == true)

		return KeybindList
	end

	Library.Notification = function(self, Data)
		wait()
		Library.NotifLayoutOrder = (Library.NotifLayoutOrder or 0) + 1

		local TitleText = Data.Title or Data.Name or Data.name or ""
		local DescText = Data.Description or Data.description or Data.Text or Data.text or ""
		local Duration = Data.Duration or Data.duration or Data.Time or Data.time or 5
		local AccentColor = Data.Color or Data.color or Library.Theme["Accent"]

		local PaddingH = 10
		local PaddingV = 8
		local Gap = 4
		local BarGap = 6
		local BarH = 3
		local AccentW = 3
		local AccentGap = 8
		local MaxWidth = 300
		local MinWidth = 160

		local function GetTextSize(Text, FontSize, Width)
			local Font = Library.Font

			if typeof(Font) ~= "EnumItem" or Font.EnumType ~= Enum.Font then
				Font = Enum.Font.Gotham
			end

			if Width <= 0 then
				Width = 10000
			end

			return TextService:GetTextSize(Text, FontSize, Font, Vector2.new(Width, 10000))
		end

		local TextWidth = MaxWidth - PaddingH * 2 - AccentW - AccentGap
		local TitleSize = TitleText ~= "" and GetTextSize(TitleText, Library.FontSettings.TextSize, TextWidth) or Vector2.new(0, 0)
		local DescSize = DescText ~= "" and GetTextSize(DescText, Library.FontSettings.SmallTextSize, TextWidth) or Vector2.new(0, 0)

		local TitleH = TitleText ~= "" and math.max(math.ceil(TitleSize.Y), Library.FontSettings.TextSize + 2) or 0
		local DescH = DescText ~= "" and math.max(math.ceil(DescSize.Y), Library.FontSettings.SmallTextSize + 2) or 0
		local HasDesc = DescText ~= "" and DescH > 0

		local ContentWidth = math.max(
			math.ceil(TitleSize.X),
			math.ceil(DescSize.X),
			MinWidth - PaddingH * 2 - AccentW - AccentGap
		)
		ContentWidth = math.min(ContentWidth + PaddingH * 2 + AccentW + AccentGap, MaxWidth)

		local BodyH = TitleH + (HasDesc and (Gap + DescH) or 0)
		local SizeY = PaddingV * 2 + BodyH + BarGap + BarH

		local Items = {} do
			Items["Notification"] = Instances:Create("Frame", {
				Parent = Library.NotifHolder.Instance,
				Name = "\0",
				BackgroundColor3 = Library.Theme["Inline"],
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				LayoutOrder = Library.NotifLayoutOrder,
				Size = UDim2New(0, 0, 0, SizeY)
			}):AddToTheme({BackgroundColor3 = "Inline"})

			Instances:Create("UICorner", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Instances:Create("UIStroke", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				Color = Library.Theme["Border"],
				Thickness = 1,
				Transparency = 0.45
			}):AddToTheme({Color = "Border"})

			Instances:Create("UIPadding", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, PaddingH),
				PaddingRight = UDimNew(0, PaddingH),
				PaddingTop = UDimNew(0, PaddingV),
				PaddingBottom = UDimNew(0, PaddingV)
			})

			Instances:Create("UIListLayout", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				Padding = UDimNew(0, BarGap),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})

			Items["Body"] = Instances:Create("Frame", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, BodyH),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				LayoutOrder = 1,
				ZIndex = 2
			})

			Instances:Create("UIListLayout", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				Padding = UDimNew(0, AccentGap),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})

			Items["AccentBar"] = Instances:Create("Frame", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				Size = UDim2New(0, AccentW, 1, 0),
				BackgroundColor3 = AccentColor,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				LayoutOrder = 1,
				ZIndex = 2
			})

			Instances:Create("UICorner", {
				Parent = Items["AccentBar"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 2)
			})

			Items["Content"] = Instances:Create("Frame", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				Size = UDim2New(1, -(AccentW + AccentGap), 0, BodyH),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				LayoutOrder = 2,
				ZIndex = 2
			})

			Instances:Create("UIListLayout", {
				Parent = Items["Content"].Instance,
				Name = "\0",
				Padding = UDimNew(0, Gap),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})

			if TitleText ~= "" then
				Items["Title"] = Instances:Create("TextLabel", {
					Parent = Items["Content"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 0, TitleH),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = TitleText,
					TextColor3 = Library.Theme["Text"],
					TextSize = Library.FontSettings.TextSize,
					FontFace = Library.Font,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextWrapped = true,
					TextTransparency = 1,
					LayoutOrder = 1,
					ZIndex = 2
				}):AddToTheme({TextColor3 = "Text"})
			end

			if HasDesc then
				Items["Description"] = Instances:Create("TextLabel", {
					Parent = Items["Content"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 0, DescH),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = DescText,
					TextColor3 = Library.Theme["Inactive Text"],
					TextSize = Library.FontSettings.SmallTextSize,
					FontFace = Library.Font,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = true,
					TextTransparency = 1,
					LayoutOrder = 2,
					ZIndex = 2
				}):AddToTheme({TextColor3 = "Inactive Text"})
			end

			Items["Duration"] = Instances:Create("Frame", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, BarH),
				BackgroundColor3 = Library.Theme["Element"],
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				LayoutOrder = 2,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = "Element"})

			Instances:Create("UICorner", {
				Parent = Items["Duration"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 2)
			})

			Items["Progress"] = Instances:Create("Frame", {
				Parent = Items["Duration"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				Position = UDim2New(0, 0, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundColor3 = AccentColor,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 3
			})

			Instances:Create("UICorner", {
				Parent = Items["Progress"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 2)
			})
		end

		local FadeInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
		local BarInfo = TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

		local FadeFrames = { Items["Notification"], Items["Duration"], Items["AccentBar"] }
		local FadeLabels = {}

		if Items["Title"] then
			TableInsert(FadeLabels, Items["Title"])
		end

		if Items["Description"] then
			TableInsert(FadeLabels, Items["Description"])
		end

		Library:Thread(function()
			for _, Item in FadeFrames do
				Item:Tween(FadeInfo, {BackgroundTransparency = 0})
			end

			for _, Item in FadeLabels do
				local Goal = Item == Items["Description"] and {TextTransparency = 0} or {TextTransparency = 0}
				Item:Tween(FadeInfo, Goal)
			end

			Items["Notification"]:Tween(FadeInfo, {Size = UDim2New(0, ContentWidth, 0, SizeY)})

			Items["Progress"].Instance.Size = UDim2New(1, 0, 1, 0)
			Items["Progress"]:Tween(FadeInfo, {BackgroundTransparency = 0})
			Items["Progress"]:Tween(BarInfo, {Size = UDim2New(0, 0, 1, 0)})

			delay(Duration + 0.15, function()
				for _, Item in FadeFrames do
					Item:Tween(FadeInfo, {BackgroundTransparency = 1})
				end

				Items["Progress"]:Tween(FadeInfo, {BackgroundTransparency = 1})

				for _, Item in FadeLabels do
					Item:Tween(FadeInfo, {TextTransparency = 1})
				end

				Items["Notification"]:Tween(FadeInfo, {Size = UDim2New(0, 0, 0, SizeY)})
				wait(0.4)
				Items["Notification"]:Clean()
			end)
		end)
	end

	Library.TargetIndicator = function(self, Data)
		Data = Data or {}

		local Indicator = {
			Title = Data.Name or Data.name or Data.Title or Data.title or "Target",
			Visible = false,
			Lines = {},
			HealthConnection = nil,
			BoundHumanoid = nil,
			BoundTarget = nil,
			Items = {},
		}

		local Items = {} do
			Items["Root"] = Instances:Create("Frame", {
				Parent = Library.Holder.Instance,
				Name = "\0",
				Position = UDim2New(0.5, -130, 0, 80),
				Size = UDim2New(0, 260, 0, 0),
				BackgroundColor3 = Library.Theme["Background"],
				BackgroundTransparency = 0.15,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				Visible = false,
				ZIndex = 4,
			}):AddToTheme({BackgroundColor3 = "Background"})

			Items["Root"]:MakeDraggable()

			Instances:Create("UICorner", {
				Parent = Items["Root"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5),
			})

			Instances:Create("UIGradient", {
				Parent = Items["Root"].Instance,
				Name = "\0",
				Rotation = 90,
				Color = RGBSequence{
					RGBSequenceKeypoint(0, FromRGB(255, 255, 255)),
					RGBSequenceKeypoint(1, FromRGB(200, 200, 200)),
				},
			})

			Items["AccentBar"] = Instances:Create("Frame", {
				Parent = Items["Root"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 2),
				BackgroundColor3 = Library.Theme["Accent"],
				BorderSizePixel = 0,
				ZIndex = 5,
			}):AddToTheme({BackgroundColor3 = "Accent"})

			Instances:Create("UICorner", {
				Parent = Items["AccentBar"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5),
			})

			Items["Body"] = Instances:Create("Frame", {
				Parent = Items["Root"].Instance,
				Name = "\0",
				Position = UDim2New(0, 0, 0, 2),
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 4,
			})

			Instances:Create("UIPadding", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				PaddingTop = UDimNew(0, 10),
				PaddingBottom = UDimNew(0, 10),
				PaddingLeft = UDimNew(0, 10),
				PaddingRight = UDimNew(0, 10),
			})

			Instances:Create("UIListLayout", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
			})

			Items["HeaderRow"] = Instances:Create("Frame", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = 0,
			})

			Instances:Create("UIListLayout", {
				Parent = Items["HeaderRow"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Top,
			})

			Items["Avatar"] = Instances:Create("ImageLabel", {
				Parent = Items["HeaderRow"].Instance,
				Name = "\0",
				Size = UDim2New(0, 52, 0, 52),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
				LayoutOrder = 0,
				ZIndex = 4,
			})

			Instances:Create("UICorner", {
				Parent = Items["Avatar"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5),
			})

			Instances:Create("UIStroke", {
				Parent = Items["Avatar"].Instance,
				Name = "\0",
				Color = Library.Theme["Border"],
				Thickness = 1,
			}):AddToTheme({Color = "Border"})

			Items["HeaderText"] = Instances:Create("Frame", {
				Parent = Items["HeaderRow"].Instance,
				Name = "\0",
				Size = UDim2New(1, -60, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = 1,
			})

			Instances:Create("UIListLayout", {
				Parent = Items["HeaderText"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
			})

			Items["Title"] = Instances:Create("TextLabel", {
				Parent = Items["HeaderText"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = Indicator.Title,
				TextColor3 = Library.Theme["Accent"],
				TextSize = 14,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = 0,
				ZIndex = 4,
			}):AddToTheme({TextColor3 = "Accent"})

			Items["Subtitle"] = Instances:Create("TextLabel", {
				Parent = Items["HeaderText"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = "No target",
				TextColor3 = Library.Theme["Inactive Text"],
				TextSize = 12,
				FontFace = Library.Font,
				TextTransparency = 0.35,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = 1,
				ZIndex = 4,
			}):AddToTheme({TextColor3 = "Inactive Text"})

			Items["InfoScroll"] = Instances:Create("ScrollingFrame", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScrollBarThickness = 2,
				ScrollBarImageColor3 = Library.Theme["Accent"],
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				CanvasSize = UDim2New(0, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = 1,
				ZIndex = 4,
			}):AddToTheme({ScrollBarImageColor3 = "Accent"})

			Instances:Create("UIPadding", {
				Parent = Items["InfoScroll"].Instance,
				Name = "\0",
				PaddingRight = UDimNew(0, 4),
			})

			Items["InfoList"] = Instances:Create("Frame", {
				Parent = Items["InfoScroll"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
			})

			Instances:Create("UIListLayout", {
				Parent = Items["InfoList"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 3),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
			})

			Items["HealthTrack"] = Instances:Create("Frame", {
				Parent = Items["Body"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 10),
				BackgroundColor3 = Library.Theme["Element"],
				BorderSizePixel = 0,
				LayoutOrder = 2,
				ZIndex = 4,
			}):AddToTheme({BackgroundColor3 = "Element"})

			Instances:Create("UICorner", {
				Parent = Items["HealthTrack"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0),
			})

			Items["HealthFill"] = Instances:Create("Frame", {
				Parent = Items["HealthTrack"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				BackgroundColor3 = Library.Theme["Accent"],
				BorderSizePixel = 0,
				ZIndex = 4,
			}):AddToTheme({BackgroundColor3 = "Accent"})

			Instances:Create("UICorner", {
				Parent = Items["HealthFill"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0),
			})

			Instances:Create("UIGradient", {
				Parent = Items["HealthFill"].Instance,
				Name = "\0",
				Rotation = 90,
				Color = RGBSequence{
					RGBSequenceKeypoint(0, FromRGB(255, 255, 255)),
					RGBSequenceKeypoint(1, FromRGB(190, 190, 190)),
				},
			})

			Items["HealthText"] = Instances:Create("TextLabel", {
				Parent = Items["HealthTrack"].Instance,
				Name = "\0",
				Size = UDim2New(1, -8, 1, 0),
				Position = UDim2New(0, 4, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = "0 / 0",
				TextColor3 = Library.Theme["Text"],
				TextSize = 11,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Right,
				ZIndex = 5,
			}):AddToTheme({TextColor3 = "Text"})
		end

		Indicator.Items = Items

		local function ClampInfoScrollHeight()
			local LineCount = 0

			for _ in Indicator.Lines do
				LineCount += 1
			end

			local TargetHeight = MathClamp(LineCount * 17, 0, 102)
			Items["InfoScroll"].Instance.Size = UDim2New(1, 0, 0, TargetHeight)
		end

		function Indicator:SetVisibility(Bool)
			Indicator.Visible = Bool and true or false
			Items["Root"].Instance.Visible = Indicator.Visible
		end

		function Indicator:SetPosition(Position)
			Items["Root"].Instance.AnchorPoint = Vector2New(0, 0)
			Items["Root"].Instance.Position = Position
		end

		function Indicator:Center()
			local AbsPos = Items["Root"].Instance.AbsolutePosition
			local GuiInset = GuiService:GetGuiInset().Y

			Items["Root"].Instance.AnchorPoint = Vector2New(0, 0)
			Items["Root"].Instance.Position = UDim2New(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
		end

		function Indicator:SetTitle(Text)
			Items["Title"].Instance.Text = tostring(Text or "")
		end

		function Indicator:SetSubtitle(Text)
			Items["Subtitle"].Instance.Text = tostring(Text or "")
		end

		function Indicator:SetAvatar(Image)
			Items["Avatar"].Instance.Image = tostring(Image or "rbxasset://textures/ui/GuiImagePlaceholder.png")
		end

		function Indicator:ResetHealthConnection()
			if Indicator.HealthConnection then
				Indicator.HealthConnection:Disconnect()
				Indicator.HealthConnection = nil
			end

			Indicator.BoundHumanoid = nil
			Indicator.BoundTarget = nil
		end

		function Indicator:SetHealth(Current, Maximum, FillColor)
			local MaxHealth = math.max(tonumber(Maximum) or 0, 1)
			local Health = math.clamp(tonumber(Current) or 0, 0, MaxHealth)
			local Alpha = Health / MaxHealth

			Items["HealthText"].Instance.Text = string.format("%d / %d", MathFloor(Health + 0.5), MathFloor(MaxHealth + 0.5))
			Items["HealthFill"]:Tween(nil, {Size = UDim2New(Alpha, 0, 1, 0)})

			if typeof(FillColor) == "Color3" then
				Items["HealthFill"].Instance.BackgroundColor3 = FillColor
			end
		end

		function Indicator:ClearInfo()
			for _, Child in Items["InfoList"].Instance:GetChildren() do
				if Child:IsA("TextLabel") then
					Child:Destroy()
				end
			end

			Indicator.Lines = {}
			ClampInfoScrollHeight()
		end

		function Indicator:RemoveLine(Key)
			local LineKey = tostring(Key)
			local LineData = Indicator.Lines[LineKey]

			if LineData and LineData.Item and LineData.Item.Instance then
				LineData.Item.Instance:Destroy()
			end

			Indicator.Lines[LineKey] = nil
			ClampInfoScrollHeight()
		end

		function Indicator:SetLine(Key, Value, Options)
			Options = Options or {}
			local LineKey = tostring(Key)
			local LineValue = tostring(Value)
			local LineText = Options.Text or string.format("%s: %s", LineKey, LineValue)
			local LayoutOrder = Options.Order or Options.layoutOrder

			if not LayoutOrder then
				local Count = 0

				for _ in Indicator.Lines do
					Count += 1
				end

				LayoutOrder = Count
			end

			local LineData = Indicator.Lines[LineKey]

			if not LineData then
				LineData = {}
				Indicator.Lines[LineKey] = LineData

				LineData.Item = Instances:Create("TextLabel", {
					Parent = Items["InfoList"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 0, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Text = LineText,
					TextColor3 = Options.Color or Library.Theme["Text"],
					TextSize = 12,
					FontFace = Library.Font,
					TextTransparency = Options.Transparency or 0.35,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					LayoutOrder = LayoutOrder,
					ZIndex = 4,
				})

				if not Options.Color then
					LineData.Item:AddToTheme({TextColor3 = "Text"})
				end
			else
				LineData.Item.Instance.Text = LineText
				LineData.Item.Instance.LayoutOrder = LayoutOrder

				if Options.Color then
					LineData.Item.Instance.TextColor3 = Options.Color
				end

				if Options.Transparency then
					LineData.Item.Instance.TextTransparency = Options.Transparency
				end
			end

			LineData.Key = LineKey
			LineData.Value = LineValue
			ClampInfoScrollHeight()
		end

		function Indicator:SetInfo(Info)
			self:ClearInfo()

			if type(Info) ~= "table" then
				return
			end

			if #Info > 0 then
				for Index, Entry in Info do
					if type(Entry) == "table" then
						local Key = Entry[1] or Entry.Key or Entry.key or Entry.Name or Entry.name or ("Line " .. Index)
						local Value = Entry[2] or Entry.Value or Entry.value or ""
						self:SetLine(Key, Value, Entry)
					elseif type(Entry) == "string" then
						self:SetLine("Info " .. Index, Entry)
					end
				end
			else
				for Key, Value in Info do
					if type(Key) == "string" and type(Value) ~= "table" and type(Value) ~= "function" then
						self:SetLine(Key, Value)
					end
				end
			end
		end

		function Indicator:UpdateInfo(Info)
			if type(Info) ~= "table" then
				return
			end

			if #Info > 0 then
				for Index, Entry in Info do
					if type(Entry) == "table" then
						local Key = Entry[1] or Entry.Key or Entry.key or Entry.Name or Entry.name
						local Value = Entry[2] or Entry.Value or Entry.value

						if Key then
							self:SetLine(Key, Value, Entry)
						end
					end
				end
			else
				for Key, Value in Info do
					if type(Key) == "string" and type(Value) ~= "table" and type(Value) ~= "function" then
						self:SetLine(Key, Value)
					end
				end
			end
		end

		function Indicator:ClearTarget()
			self:ResetHealthConnection()
			self:SetSubtitle("No target")
			self:SetAvatar("rbxasset://textures/ui/GuiImagePlaceholder.png")
			self:SetHealth(0, 0)
		end

		function Indicator:SetTarget(Target)
			self:ResetHealthConnection()

			if not Target then
				self:ClearTarget()
				return false
			end

			local TargetName = "Unknown"
			local TargetUserId = nil

			if typeof(Target) == "Instance" then
				if Target:IsA("Player") then
					TargetName = Target.Name
					TargetUserId = Target.UserId
					Indicator.BoundTarget = Target
				elseif Target:IsA("Model") then
					TargetName = Target.Name

					local Player = Players:GetPlayerFromCharacter(Target)
					if Player then
						TargetUserId = Player.UserId
						Indicator.BoundTarget = Player
					end
				elseif Target:IsA("Humanoid") then
					local Model = Target.Parent
					TargetName = Model and Model.Name or TargetName

					local Player = Model and Players:GetPlayerFromCharacter(Model)
					if Player then
						TargetUserId = Player.UserId
						Indicator.BoundTarget = Player
					end

					Indicator.BoundHumanoid = Target
				end
			end

			self:SetSubtitle(TargetName)

			if TargetUserId then
				local Success, Thumbnail = pcall(function()
					return Players:GetUserThumbnailAsync(TargetUserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
				end)

				if Success and Thumbnail then
					self:SetAvatar(Thumbnail)
				end
			end

			local Humanoid = Indicator.BoundHumanoid

			if not Humanoid and Indicator.BoundTarget and Indicator.BoundTarget.Character then
				Humanoid = Indicator.BoundTarget.Character:FindFirstChildOfClass("Humanoid")
			end

			if typeof(Target) == "Instance" and Target:IsA("Model") and not Humanoid then
				Humanoid = Target:FindFirstChildOfClass("Humanoid")
			end

			if not Humanoid then
				self:SetHealth(0, 0)
				return false
			end

			Indicator.BoundHumanoid = Humanoid

			local function OnHealthChanged(Health)
				if Indicator.BoundHumanoid ~= Humanoid then
					return
				end

				self:SetHealth(Health, Humanoid.MaxHealth)
			end

			OnHealthChanged(Humanoid.Health)
			Indicator.HealthConnection = Humanoid.HealthChanged:Connect(OnHealthChanged)

			return true
		end

		function Indicator:Show()
			self:SetVisibility(true)
		end

		function Indicator:Hide()
			self:SetVisibility(false)
		end

		Indicator:SetHealth(0, 100)
		Indicator:Center()

		return Indicator
	end

	Library.Window = function(self, Data)
		Data = Data or {}

		self:BeginUILoading()

		local Window = {
			Name = Data.Name or Data.name or "Window",

			Pages = {},
			Items = {},
			IsOpen = false,
			IsMinimized = false
		}

		local Items = {} do
			Items["MainFrame"] = Instances:Create("Frame", {
				Parent = Library.Holder.Instance,
				Name = "\0",
				Size = UDim2New(0, 770, 0, 526),
				Position = UDim2New(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2New(0.5, 0.5),
				BackgroundColor3 = Library.Theme["Background"],
				BackgroundTransparency = 0.30000001192092896,
				BorderColor3 = Library.Theme["Shadow"],
				BorderSizePixel = 0,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Background'})

			Library.MainWindowFrame = Items["MainFrame"].Instance

			wait()

			Library:SetScaleFromScreenPercent(Library.UIScaleScreenPercent)

			Items["MainFrame"]:MakeDraggable()
			Items["MainFrame"]:MakeResizeable(Vector2New(Items["MainFrame"].Instance.AbsoluteSize.X, Items["MainFrame"].Instance.AbsoluteSize.Y))

			Instances:Create("UICorner", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Shadow"] = Instances:Create("ImageLabel", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(1, 55, 1, 55),
				Position = UDim2New(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2New(0.5, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = Library.Theme["Shadow"],
				BorderSizePixel = 0,
				Image = "rbxassetid://112971167999062",
				ImageColor3 = Library.Theme["Shadow"],
				ImageTransparency = 0.5600000023841858,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = RectNew(Vector2New(112, 112), Vector2New(147, 147)),
				SliceScale = 0.6000000238418579,
				ZIndex = -1
			}):AddToTheme({ImageColor3 = 'Shadow'})

			Items["Title"] = Instances:Create("TextLabel", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 15),
				Position = UDim2New(0, 9, 0, 8),
				BackgroundTransparency = 1,
				BorderColor3 = Library.Theme["Shadow"],
				BorderSizePixel = 0,
				Text = Window.Name,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				AutomaticSize = Enum.AutomaticSize.X,
				ZIndex = 4
			}):AddToTheme({TextColor3 = 'Text'})  

			Items["Pages"] = Instances:Create("ScrollingFrame", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(0, 150, 1, -30),
				Position = UDim2New(0, 0, 0, 30),
				BackgroundColor3 = FromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				BottomImage = "rbxassetid://136419474381965",
				CanvasSize = UDim2New(0, 0, 0, 0),
				MidImage = "rbxassetid://136419474381965",
				ScrollBarImageColor3 = Library.Theme["Accent"],
				ScrollBarThickness = 3,
				TopImage = "rbxassetid://136419474381965"
			}):AddToTheme({ScrollBarImageColor3 = 'Accent'})

			Instances:Create("UIListLayout", {
				Parent = Items["Pages"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			Instances:Create("UIPadding", {
				Parent = Items["Pages"].Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, 8),
				PaddingRight = UDimNew(0, 8)
			})

			Items["CloseButton"] = Instances:Create("ImageButton", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(0, 23, 0, 23),
				Position = UDim2New(1, -12, 0, 5),
				AnchorPoint = Vector2New(1, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://76001605964586",
				ScaleType = Enum.ScaleType.Fit,
				AutoButtonColor = false,
				ZIndex = 2
			})                

			Items["MinimizeButton"] = Instances:Create("ImageButton", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(0, 23, 0, 23),
				Position = UDim2New(1, -40, 0, -1.75),
				AnchorPoint = Vector2New(1, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://94817928404736",
				AutoButtonColor = false,
				ZIndex = 2
			})                

			Items["Content"] = Instances:Create("Frame", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(1, -171, 1, -38),
				Position = UDim2New(0, 163, 0, 30),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			})

			Items["Search"] = Instances:Create("Frame", {
				Parent = Items["Content"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 35),
				BackgroundColor3 = Library.Theme["Inline"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = Items["Search"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Icon"] = Instances:Create("ImageLabel", {
				Parent = Items["Search"].Instance,
				Name = "\0",
				Size = UDim2New(0, 20, 0, 20),
				Position = UDim2New(0, 8, 0.5, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://71924825350727",
				ImageTransparency = 0.4000000059604645,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 2
			})

			Items["Input"] = Instances:Create("TextBox", {
				Parent = Items["Search"].Instance,
				Name = "\0",
				Size = UDim2New(1, -43, 0, 15),
				Position = UDim2New(0, 35, 0.5, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				PlaceholderText = "Search..",
				PlaceholderColor3 = Library.Theme["Inactive Text"],
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})    

			Instances:Create("Frame", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(0, 1, 1, -30),
				Position = UDim2New(0, 152, 0, 30),
				BackgroundColor3 = Library.Theme["Border"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Border'})   

			Items["FloatingButton"] = Instances:Create("ImageButton", {
				Parent = Library.FloatingButtonHolder.Instance,
				Name = "\0",
				Size = UDim2New(0, 50, 0, 50),
				Position = UDim2New(0, 15, 0, 50),
				AnchorPoint = Vector2New(0, 0),
				BackgroundColor3 = Library.Theme['Background'],
				Image = "rbxassetid://137698471325689",
				ImageColor3 = Library.Theme['Accent'],
				AutoButtonColor = false,
				ZIndex = 128
			}):AddToTheme({BackgroundColor3 = 'Background'})

			Instances:Create("UICorner", {
				Parent = Items["FloatingButton"].Instance,
				CornerRadius = UDimNew(0, 10)
			})

			Library.FloatingButton = Items["FloatingButton"]
			Library.FloatingButtonLocked = false
			Library.FloatingButtonVisibility = 0

			local FloatingButtonDragging = false
			local FloatingButtonDragStart
			local FloatingButtonStartPosition
			local FloatingButtonMoveConnection
			local FloatingButtonEndConnection

			local function StopFloatingButtonDrag()
				FloatingButtonDragging = false
				FloatingButtonDragStart = nil
				FloatingButtonStartPosition = nil

				if FloatingButtonMoveConnection then
					pcall(function()
						FloatingButtonMoveConnection:Disconnect()
					end)
					FloatingButtonMoveConnection = nil
				end

				if FloatingButtonEndConnection then
					pcall(function()
						FloatingButtonEndConnection:Disconnect()
					end)
					FloatingButtonEndConnection = nil
				end
			end

			Items["FloatingButton"]:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if Library.FloatingButtonLocked then
						return
					end

					StopFloatingButtonDrag()

					local FloatingGui = Items["FloatingButton"].Instance
					NormalizeDragPosition(FloatingGui)

					FloatingButtonDragging = true
					FloatingButtonDragStart = GetMouseLocation()
					FloatingButtonStartPosition = FloatingGui.Position

					FloatingButtonMoveConnection = UserInputService.InputChanged:Connect(function(MoveInput)
						if not FloatingButtonDragging or Library.FloatingButtonLocked or not FloatingButtonDragStart or not FloatingButtonStartPosition then
							return
						end

						if MoveInput.UserInputType ~= Enum.UserInputType.MouseMovement and MoveInput.UserInputType ~= Enum.UserInputType.Touch then
							return
						end

						local Mouse = GetMouseLocation()
						local DragDelta = Mouse - FloatingButtonDragStart

						FloatingGui.Position = UDim2New(
							FloatingButtonStartPosition.X.Scale,
							FloatingButtonStartPosition.X.Offset + DragDelta.X,
							FloatingButtonStartPosition.Y.Scale,
							FloatingButtonStartPosition.Y.Offset + DragDelta.Y
						)
					end)

					FloatingButtonEndConnection = UserInputService.InputEnded:Connect(function(EndInput)
						if not FloatingButtonDragging then
							return
						end

						if EndInput.UserInputType == Enum.UserInputType.MouseButton1 or EndInput.UserInputType == Enum.UserInputType.Touch then
							StopFloatingButtonDrag()
						end
					end)
				end
			end)

			Items["FloatingButton"]:Connect("MouseButton1Down", function()
				Window:SetOpen(not Window.IsOpen)
			end)

			Window.Items = Items
		end

		local OldSize = Items["MainFrame"].Instance.AbsoluteSize
		local MinimizedSize = UDim2New(0, 285, 0, 35)

		Items["MainFrame"].Instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if not Window.IsMinimized then
				OldSize = Items["MainFrame"].Instance.AbsoluteSize
			end
		end)

		function Window:Minimize(Bool)
			for Index, Value in Library.OpenFrames do
				if type(Value.SetOpen) == "function" then
					Value:SetOpen(false)
				end
			end

			Window.IsMinimized = Bool

			if Window.IsMinimized then
				Items["MainFrame"]:Tween(nil, {Size = MinimizedSize})

				Items["Pages"].Instance.Visible = false
				Items["Content"].Instance.Visible = false
			else
				Items["MainFrame"]:Tween(nil, {Size = UDim2New(0, OldSize.X, 0, OldSize.Y)})

				Items["Pages"].Instance.Visible = true
				Items["Content"].Instance.Visible = true

				wait()

				local CurrentPage = Library.CurrentPage
				if CurrentPage then
					CurrentPage:Turn(true)
				end
			end
		end

		function Window:ChangeSize(XSize, YSize)
			Items["MainFrame"]:Tween(nil, {Size = UDim2New(0, XSize, 0, YSize)})
		end

		local Debounce = false

		function Window:SetCenter()
			Items["MainFrame"].Instance.AnchorPoint = Vector2New(0.5, 0.5)
			Items["MainFrame"].Instance.Position = UDim2New(0.5, 0, 0.5, 0)
		end

		function Window:SetTransparency()
			Items["MainFrame"].Instance.BackgroundTransparency = Library.BackgroundTransparency
		end

		function Window:SetOpen(Bool)
			if Debounce then 
				return
			end

			Window.IsOpen = Bool
			Library.WindowOpenState = Bool

			Library:ApplyMouseForMenu(Bool)
			Library:ApplyWindowInputState(Bool)
			Library:SetBackgroundEffectsVisible(Bool)

			Debounce = true 

			if Window.IsOpen then 
				wait()
				Items["MainFrame"].Instance.Visible = true 
			end

			for Index, Value in Library.OpenFrames do
				if type(Value.SetOpen) == "function" then
					Value:SetOpen(false)
				end
			end

			local Descendants = Items["MainFrame"].Instance:GetDescendants()
			TableInsert(Descendants, Items["MainFrame"].Instance)

			local NewTween

			for Index, Value in Descendants do 
				local TransparencyProperty = Tween:GetProperty(Value)

				if not TransparencyProperty then
					continue 
				end

				if type(TransparencyProperty) == "table" then 
					for _, Property in TransparencyProperty do 
						NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
					end
				else
					NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
				end
			end

			if not NewTween or not NewTween.Tween then
				Debounce = false

				Items["MainFrame"].Instance.Visible = Window.IsOpen
				return
			end

			NewTween.Tween.Completed:Connect(function()
				Debounce = false

				Items["MainFrame"].Instance.Visible = Window.IsOpen
			end)
		end

		function Window:Init()
			Library:Connect(Players.PlayerRemoving, function(Player)
				if Player == LocalPlayer and Library.AutoSave then
					pcall(function()
						writefile(GetAutoloadPath(), Library:GetConfig())
					end)
				end
			end)
		end

		Library:Connect(UserInputService.InputBegan, function(Input)
			if is_keybind_none_key(Library.MenuKeybind) then
				return
			end
			if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
				Window:SetOpen(not Window.IsOpen)
			end
		end)

		Items["MinimizeButton"]:Connect("MouseButton1Down", function()
			Window:Minimize(not Window.IsMinimized)
		end)

		Items["CloseButton"]:Connect("MouseButton1Down", function()
			Library:Unload()
		end)

		Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
			local CurrentPage = Library.CurrentPage
			if not CurrentPage then
				return
			end

			local SearchText = Items["Input"].Instance.Text
			local SearchActive = SearchText and SearchText ~= ""

			local function SearchInPage(PageSearchData)
				if not PageSearchData then
					return
				end

			for Index, Value in PageSearchData do
				local Name = Value.Name
				local Element = Value.Element
				local Matches = SearchActive and StringFind(StringLower(Name), StringLower(SearchText)) ~= nil

				if Matches then
					Element.Instance.Visible = true

					if Value.Type and Value.Type == "Button" then
						Value.Element2.Instance.Visible = true
					end

					local ContentParent = Element.Instance.Parent
					if ContentParent then
						local ContentHolder = ContentParent
						local SectionFrame = ContentHolder.Parent

						if SectionFrame and SectionFrame:IsA("Frame") then
							local IsSection = false

							for _, Section in Library.AllSections do
								if Section.Items and Section.Items["Section"] and Section.Items["Section"].Instance == SectionFrame then
									IsSection = true

									if Section.Collapsed then
										Section:SetCollapsed(false)
									end

									break
								end
							end
						end
					end
				else
					Element.Instance.Visible = not SearchActive

					if Value.Type and Value.Type == "Button" then
						Value.Element2.Instance.Visible = not SearchActive
					end
				end
			end
			end

			SearchInPage(Library.SearchItems[CurrentPage])

			if CurrentPage.HasSubPages then
				for _, SubPage in CurrentPage.SubPages do
					SearchInPage(Library.SearchItems[SubPage])
				end
			end
		end)

		Window:SetCenter()
		wait()
		if Data.Minimized or Data.minimized then
			Window.IsMinimized = true

			Items["MainFrame"].Instance.Size = UDim2New(0, 285, 0, 35)
			Items["Pages"].Instance.Visible = false
			Items["Content"].Instance.Visible = false
		end

		Library:LoadLocalSettings()

		if Library.SafeMode then
			Window:SetOpen(false)

			if Library.FloatingButtonHolder then
				Library.FloatingButtonHolder.Instance.Enabled = Library.ShowMenuButton ~= false
			end
		else
			Window:SetOpen(true)
		end

		return setmetatable(Window, Library)
	end

	local COLUMN_GAP = 8

	local function BindTwoColumnLayout(Container, ColumnsData)
		local HalfGap = math.ceil(COLUMN_GAP / 2)

		local function Update()
			local Width = Container.AbsoluteSize.X
			local Height = Container.AbsoluteSize.Y
			if Width < 2 or Height < 2 then
				return
			end

			local Column1 = ColumnsData[1]
			local Column2 = ColumnsData[2]

			if Column1 then
				Column1.Instance.AnchorPoint = Vector2New(0, 0)
				Column1.Instance.Position = UDim2New(0, 0, 0, 0)
				Column1.Instance.Size = UDim2New(0.5, -HalfGap, 1, 0)
			end

			if Column2 then
				Column2.Instance.AnchorPoint = Vector2New(0, 0)
				Column2.Instance.Position = UDim2New(0.5, HalfGap, 0, 0)
				Column2.Instance.Size = UDim2New(0.5, -HalfGap, 1, 0)
			end
		end

		Container:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)
		defer(Update)
		task.delay(0.05, Update)

		return Update
	end

	Library.SetActiveSubPage = function(Page, ActiveSubPage)
		if not Page or not ActiveSubPage then
			return
		end

		local Holder = Page.Items and Page.Items["SubPageHolder"]
		if not Holder then
			return
		end

		Page.ActiveSubPage = ActiveSubPage

		local SubPages = Page.SubPages
		if not SubPages then
			return
		end

		ActiveSubPage:Turn(true)
	end

	Library.Page = function(self, Data)
		Data = Data or {}

		local Page = {
			Window = self,

			Name = Data.Name or Data.name or "Page",
			Columns = 2,
			IsKeyPage = Data.IsKeyPage or Data.iskeypage or false,

			Items = {},
			ColumnsData = {},
			SubPages = {},
			ActiveSubPage = nil,
			HasSubPages = false,
			Active = false,
		}

		local PAGE_TOP_OFFSET = 43
		local SUBPAGE_BAR_HEIGHT = 38

		local Items = {} do
			Items["Inactive"] = Instances:Create("TextButton", {
				Parent = Page.Window.Items["Pages"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 35),
				BackgroundColor3 = Library.Theme["Inline"],
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				ClipsDescendants = true,
				AutoButtonColor = false,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = Items["Inactive"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Liner"] = Instances:Create("Frame", {
				Parent = Items["Inactive"].Instance,
				Name = "\0",
				Size = UDim2New(0, 6, 0, 0),
				Position = UDim2New(0, -3, 0.5, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BackgroundColor3 = FromRGB(255, 174, 254),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Accent'})

			Instances:Create("UICorner", {
				Parent = Items["Liner"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})

			Items["Text"] = Instances:Create("TextLabel", {
				Parent = Items["Inactive"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 15),
				Position = UDim2New(0, 4, 0.5, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Page.Name,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				AutomaticSize = Enum.AutomaticSize.X,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})

			Localization:ApplyText(Items["Text"].Instance, Page.Name, "Text")

			Items["Page"] = Instances:Create("Frame", {
				Parent = Library.UnusedHolder.Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				BackgroundColor3 = FromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				ZIndex = 2,
				Visible = false
			})

			Items["SubPages"] = Instances:Create("Frame", {
				Parent = Items["Page"].Instance,
				Name = "\0",
				Size = UDim2New(1, -16, 0, 0),
				Position = UDim2New(0, 8, 0, PAGE_TOP_OFFSET),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Visible = false,
				ZIndex = 10,
			})

			Instances:Create("UIListLayout", {
				Parent = Items["SubPages"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			})

			Instances:Create("UIPadding", {
				Parent = Items["SubPages"].Instance,
				Name = "\0",
				PaddingTop = UDimNew(0, 6),
				PaddingBottom = UDimNew(0, 6),
				PaddingLeft = UDimNew(0, 2),
				PaddingRight = UDimNew(0, 2),
			})

			if not Page.IsKeyPage then
				Items["Columns"] = Instances:Create("Frame", {
					Parent = Items["Page"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 1, -PAGE_TOP_OFFSET),
					Position = UDim2New(0, 0, 0, PAGE_TOP_OFFSET),
					BackgroundColor3 = FromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 1,
				})

				for Index = 1, Page.Columns do 
					local NewColumn = Instances:Create("ScrollingFrame", {
						Parent = Items["Columns"].Instance,
						Name = "\0",
						Size = UDim2New(0, 100, 1, 0),
						BackgroundColor3 = FromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = FromRGB(0, 0, 0),
						BorderSizePixel = 0,
						ClipsDescendants = true,
						Active = true,
						ZIndex = 2,
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						BottomImage = "rbxassetid://128693616966482",
						CanvasSize = UDim2New(0, 0, 0, 0),
						MidImage = "rbxassetid://128693616966482",
						ScrollBarImageColor3 = FromRGB(0, 0, 0),
						ScrollBarThickness = 3,
						ScrollBarInset = Enum.ScrollBarInset.Always,
						TopImage = "rbxassetid://128693616966482"
					})  NewColumn:AddToTheme({ScrollBarImageColor3 = "Accent"})

					Instances:Create("UIListLayout", {
						Parent = NewColumn.Instance,
						Name = "\0",
						Padding = UDimNew(0, 8),
						SortOrder = Enum.SortOrder.LayoutOrder
					})

					Instances:Create("UIPadding", {
						Parent = NewColumn.Instance,
						Name = "\0",
						PaddingRight = UDimNew(0, 10),
						PaddingBottom = UDimNew(0, 24)
					})

					local ColumnLayout = NewColumn.Instance:FindFirstChildOfClass("UIListLayout")
					if ColumnLayout then
						ColumnLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
							NewColumn.Instance.CanvasSize = UDim2.new(0, 0, 0, ColumnLayout.AbsoluteContentSize.Y + 24)
						end)
					end

					Page.ColumnsData[Index] = NewColumn
				end

				Page.UpdateColumnLayout = BindTwoColumnLayout(Items["Columns"].Instance, Page.ColumnsData)
			else
				Items["Page"].Instance.Size = UDim2New(1, 0, 1, -43)
				Items["Page"].Instance.Position = UDim2New(0, 0, 0, 43)

				Instances:Create("UIListLayout", {
					Parent = Items["Page"].Instance,
					Name = "\0",
					Padding = UDimNew(0, 15),
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center
				})
			end

			Page.Items = Items
		end

		Library.SearchItems[Page] = {}

		local Debounce = false

		function Page:PrepareForSubPages()
			if Page._SubPagesPrepared then
				return
			end

			Page._SubPagesPrepared = true

			for Index = 1, 2 do
				local Column = Page.ColumnsData[Index]
				if Column then
					Column.Instance.Visible = false
					Column.Instance.Parent = Library.UnusedHolder.Instance
				end
			end

			if Items["Columns"] and not Items["SubPageHolder"] then
				Items["SubPageHolder"] = Instances:Create("Frame", {
					Parent = Items["Columns"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 1, 0),
					Position = UDim2New(0, 0, 0, 0),
					AnchorPoint = Vector2New(0, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 1,
				})
			end
		end

		function Page:SetActiveSubPage(ActiveSubPage)
			Library.SetActiveSubPage(self, ActiveSubPage)
		end

		function Page:UpdateContentLayout()
			local Top = PAGE_TOP_OFFSET

			if Page.HasSubPages and Items["SubPages"] then
				Items["SubPages"].Instance.Visible = true
				Items["SubPages"].Instance.Size = UDim2New(1, -16, 0, SUBPAGE_BAR_HEIGHT)
				Top = PAGE_TOP_OFFSET + SUBPAGE_BAR_HEIGHT
			elseif Items["SubPages"] then
				Items["SubPages"].Instance.Visible = false
				Items["SubPages"].Instance.Size = UDim2New(1, -16, 0, 0)
			end

			if Items["Columns"] then
				Items["Columns"].Instance.Position = UDim2New(0, 0, 0, Top)
				Items["Columns"].Instance.Size = UDim2New(1, 0, 1, -Top)
			end
		end

		function Page:Turn(Bool)
			Page.Active = Bool

			if Page.Active then
				local ContentFrame = Page.Window.Items["Content"].Instance
				local IsWindowMinimized = Page.Window.IsMinimized

				if not IsWindowMinimized then
					ContentFrame.Visible = true
					wait()
					Items["Page"].Instance.Parent = ContentFrame
					Items["Page"].Instance.Visible = true
				else
					Items["Page"].Instance.Parent = Library.UnusedHolder.Instance
					Items["Page"].Instance.Visible = false
				end

				Items["Liner"]:Tween(nil, {BackgroundTransparency = 0, Size = UDim2New(0, 6, 1, -20)})
				Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0})
				Items["Text"]:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 12, 0.5, 0)})
				wait()
				Library.CurrentPage = Page

				if Page.HasSubPages and Page.SubPages[1] then
					local ActiveSubPage = Page.ActiveSubPage

					if not ActiveSubPage or not ActiveSubPage.Active then
						ActiveSubPage = Page.SubPages[1]
					end

					ActiveSubPage:Turn(true)
				elseif Page.UpdateColumnLayout then
					defer(Page.UpdateColumnLayout)
				end
			else
				Items["Liner"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(0, 6, 0, 0)})
				Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1})
				Items["Text"]:Tween(nil, {TextTransparency = 0.4, Position = UDim2New(0, 4, 0.5, 0)})
				Items["Page"].Instance.Visible = false
				wait()
				Items["Page"].Instance.Parent = Library.UnusedHolder.Instance

				if Page.HasSubPages then
					for _, SubPage in Page.SubPages do
						SubPage.Active = false

						if SubPage.Items and SubPage.Items["SubPage"] then
							SubPage.Items["SubPage"].Instance.Visible = false
						end
					end

					Page.ActiveSubPage = nil
				end
			end
		end

		Items["Inactive"]:Connect("MouseButton1Down", function()
			for Index, Value in Page.Window.Pages do 
				if Value == Page and Page.Active then
					return
				end

				Value:Turn(Value == Page)
			end
		end)

		if #Page.Window.Pages == 0 then 
			Page:Turn(true)
		end

		TableInsert(Page.Window.Pages, Page)

		return setmetatable(Page, Library.Pages)
	end

	Library.Pages.SubPage = function(self, Data)
		Data = Data or {}

		local ParentPage = self

		local SubPage = {
			Window = ParentPage.Window,
			Page = ParentPage,

			Name = Data.Name or Data.name or "Tab",
			Columns = 2,

			Items = {},
			ColumnsData = {},
			Active = false,
		}

		if not ParentPage.HasSubPages then
			ParentPage.HasSubPages = true
			ParentPage:PrepareForSubPages()
			ParentPage:UpdateContentLayout()
		end

		local SUBTAB_BG_Z = 11
		local SUBTAB_BG_ACTIVE_Z = 20
		local SUBTAB_LINER_Z = 24
		local SUBTAB_TEXT_Z = 25
		local SUBTAB_PAD_H = 14
		local SUBTAB_HEIGHT = 30
		local SUBTAB_LINER_INSET = 8

		local Items = {} do
			Items["Tab"] = Instances:Create("Frame", {
				Parent = ParentPage.Items["SubPages"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, SUBTAB_HEIGHT),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.X,
				ClipsDescendants = false,
				ZIndex = SUBTAB_BG_Z,
			})

			Items["TabSizer"] = Instances:Create("TextLabel", {
				Parent = Items["Tab"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 15),
				Position = UDim2New(0, 0, 0.5, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = SubPage.Name,
				TextSize = 13,
				FontFace = Library.Font,
				TextTransparency = 1,
				AutomaticSize = Enum.AutomaticSize.X,
				ZIndex = 0,
			})

			Items["TabBg"] = Instances:Create("Frame", {
				Parent = Items["Tab"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				BackgroundColor3 = Library.Theme["Inline"],
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = SUBTAB_BG_Z,
			}):AddToTheme({BackgroundColor3 = "Inline"})

			Instances:Create("UICorner", {
				Parent = Items["TabBg"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5),
			})

			Items["TabLiner"] = Instances:Create("Frame", {
				Parent = Items["Tab"].Instance,
				Name = "\0",
				Size = UDim2New(1, -SUBTAB_LINER_INSET * 2, 0, 0),
				Position = UDim2New(0, SUBTAB_LINER_INSET, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundColor3 = Library.Theme["Accent"],
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = SUBTAB_LINER_Z,
			}):AddToTheme({BackgroundColor3 = "Accent"})

			Instances:Create("UICorner", {
				Parent = Items["TabLiner"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 2),
			})

			Items["TabText"] = Instances:Create("TextLabel", {
				Parent = Items["Tab"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 15),
				Position = UDim2New(0, 0, 0.5, 0),
				AnchorPoint = Vector2New(0, 0.5),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = SubPage.Name,
				TextColor3 = Library.Theme["Text"],
				TextSize = 13,
				FontFace = Library.Font,
				TextTransparency = 0.4,
				TextXAlignment = Enum.TextXAlignment.Center,
				ZIndex = SUBTAB_TEXT_Z,
			}):AddToTheme({TextColor3 = "Text"})

			Items["TabHit"] = Instances:Create("TextButton", {
				Parent = Items["Tab"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = "",
				AutoButtonColor = false,
				ZIndex = SUBTAB_TEXT_Z + 1,
			})

			Localization:ApplyText(Items["TabText"].Instance, SubPage.Name, "Text")
			Localization:ApplyText(Items["TabSizer"].Instance, SubPage.Name, "Text")

			Instances:Create("UIPadding", {
				Parent = Items["Tab"].Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, SUBTAB_PAD_H),
				PaddingRight = UDimNew(0, SUBTAB_PAD_H),
			})

			local SubPageHolder = ParentPage.Items["SubPageHolder"]
			Items["SubPage"] = Instances:Create("Frame", {
				Parent = SubPageHolder and SubPageHolder.Instance or Library.UnusedHolder.Instance,
				Name = "SubPage_" .. SubPage.Name,
				Size = UDim2New(1, 0, 1, 0),
				Position = UDim2New(0, 0, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Visible = false,
				ZIndex = 1,
			})

			for Index = 1, SubPage.Columns do
				local NewColumn = Instances:Create("ScrollingFrame", {
					Parent = Items["SubPage"].Instance,
					Name = "\0",
					Size = UDim2New(0, 100, 1, 0),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Active = true,
					ZIndex = 2,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BottomImage = "rbxassetid://128693616966482",
					CanvasSize = UDim2New(0, 0, 0, 0),
					MidImage = "rbxassetid://128693616966482",
					ScrollBarImageColor3 = FromRGB(0, 0, 0),
					ScrollBarThickness = 3,
					ScrollBarInset = Enum.ScrollBarInset.Always,
					TopImage = "rbxassetid://128693616966482",
				}):AddToTheme({ScrollBarImageColor3 = "Accent"})

				Instances:Create("UIListLayout", {
					Parent = NewColumn.Instance,
					Name = "\0",
					Padding = UDimNew(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
				})

				Instances:Create("UIPadding", {
					Parent = NewColumn.Instance,
					Name = "\0",
					PaddingRight = UDimNew(0, 10),
					PaddingBottom = UDimNew(0, 24),
				})

				local ColumnLayout = NewColumn.Instance:FindFirstChildOfClass("UIListLayout")
				if ColumnLayout then
					ColumnLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						NewColumn.Instance.CanvasSize = UDim2New(0, 0, 0, ColumnLayout.AbsoluteContentSize.Y + 24)
					end)
				end

				SubPage.ColumnsData[Index] = NewColumn
			end

			SubPage.UpdateColumnLayout = BindTwoColumnLayout(Items["SubPage"].Instance, SubPage.ColumnsData)

			SubPage.Items = Items
		end

		Library.SearchItems[SubPage] = {}

		function SubPage:Turn(Bool)
			SubPage.Active = Bool

			if SubPage.Active then
				for _, OtherSubPage in ParentPage.SubPages do
					if OtherSubPage ~= SubPage and OtherSubPage.Active then
						OtherSubPage:Turn(false)
					end
				end

				ParentPage.ActiveSubPage = SubPage

				local ContentParent = ParentPage.Items["SubPageHolder"]
				if ParentPage.Active and ContentParent then
					Items["SubPage"].Instance.Parent = ContentParent.Instance
					Items["SubPage"].Instance.Position = UDim2New(0, 0, 0, 0)
					Items["SubPage"].Instance.Size = UDim2New(1, 0, 1, 0)
					Items["SubPage"].Instance.Visible = true

					if SubPage.UpdateColumnLayout then
						SubPage.UpdateColumnLayout()
						defer(SubPage.UpdateColumnLayout)
					end
				end

				Items["Tab"].Instance.ZIndex = SUBTAB_BG_ACTIVE_Z
				Items["TabBg"].Instance.ZIndex = SUBTAB_BG_ACTIVE_Z
				Items["Tab"].Instance.Parent = ParentPage.Items["SubPages"].Instance

				Items["TabBg"]:Tween(nil, {BackgroundTransparency = 0})
				Items["TabLiner"]:Tween(nil, {
					BackgroundTransparency = 0,
					Size = UDim2New(1, -SUBTAB_LINER_INSET * 2, 0, 3),
				})
				Items["TabText"]:Tween(nil, {TextTransparency = 0})
			else
				Items["SubPage"].Instance.Visible = false

				for ColumnIndex = 1, 2 do
					local Column = SubPage.ColumnsData[ColumnIndex]
					if Column then
						Column.Instance.Active = false
					end
				end

				if ParentPage.ActiveSubPage == SubPage then
					ParentPage.ActiveSubPage = nil
				end

				Items["Tab"].Instance.ZIndex = SUBTAB_BG_Z
				Items["TabBg"].Instance.ZIndex = SUBTAB_BG_Z

				Items["TabBg"]:Tween(nil, {BackgroundTransparency = 1})
				Items["TabLiner"]:Tween(nil, {
					BackgroundTransparency = 1,
					Size = UDim2New(1, -SUBTAB_LINER_INSET * 2, 0, 0),
				})
				Items["TabText"]:Tween(nil, {TextTransparency = 0.4})
			end
		end

		Items["TabHit"]:Connect("MouseButton1Down", function()
			if SubPage.Active then
				return
			end

			for _, OtherSubPage in ParentPage.SubPages do
				OtherSubPage:Turn(OtherSubPage == SubPage)
			end
		end)

		if #ParentPage.SubPages == 0 then
			SubPage:Turn(true)
		end

		TableInsert(ParentPage.SubPages, SubPage)

		return setmetatable(SubPage, Library.Pages)
	end

	Library.Pages.Section = function(self, Data)
		Data = Data or {}

		local CollapsedDefault = true
		if Data.Collapsed == false then
			CollapsedDefault = false
		end

		local Section = {
			Window = self.Window,
			Page = self,

			Name = Data.Name or Data.name or "Section",
			Side = ((Data.Side or Data.side or 1) == 2) and 2 or 1,
			Collapsed = CollapsedDefault,

			Items = {}
		}

		local Items = {}

		Items["Section"] = Instances:Create("Frame", {
			Parent = Section.Page.ColumnsData[Section.Side].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 28),
			BackgroundColor3 = Library.Theme["Inline"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Inline'})

		Instances:Create("UICorner", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIGradient", {
			Parent = Items["Section"].Instance,
			Name = "\0"
		})

		Items["Header"] = Instances:Create("TextButton", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 28),
			Position = UDim2New(0, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			ZIndex = 2
		})

		Items["Text"] = Instances:Create("TextLabel", {
			Parent = Items["Header"].Instance,
			Name = "\0",
			Size = UDim2New(0, 0, 0, 15),
			Position = UDim2New(0, 8, 0, 7),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = Section.Name,
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			AutomaticSize = Enum.AutomaticSize.X,
			ZIndex = 2
		}):AddToTheme({TextColor3 = 'Text'})

		Localization:ApplyText(Items["Text"].Instance, Section.Name, "Text")

		Items["Indicator"] = Instances:Create("ImageLabel", {
			Parent = Items["Header"].Instance,
			Name = "\0",
			Size = UDim2New(0, 23, 0, 23),
			Position = UDim2New(1, -15, 0.5, 0),
			AnchorPoint = Vector2New(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://126603363478667",
			ImageColor3 = Library.Theme["Text"],
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 2
		})

		Items["Line"] = Instances:Create("Frame", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 0, 1),
			Position = UDim2New(0, 8, 0, 28),
			BackgroundColor3 = Library.Theme["Border"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Border'})

		Items["ContentHolder"] = Instances:Create("Frame", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 0, 0),
			Position = UDim2New(0, 8, 0, 32),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		})

		Items["Content"] = Instances:Create("Frame", {
			Parent = Items["ContentHolder"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 0),
			Position = UDim2New(0, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		})

		Instances:Create("UIPadding", {
			Parent = Items["Content"].Instance,
			Name = "\0",
			PaddingTop = UDimNew(0, 6),
			PaddingBottom = UDimNew(0, 6)
		})

		local ListLayout = Instances:Create("UIListLayout", {
			Parent = Items["Content"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder
		})

		local CurrentHeight = 0
		local SizeDebounce = false

		local TweenInfo_Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local TweenInfo_Normal = TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

		local UpdateSize_Connection = nil

		local function UpdateSize()
			if Section.Collapsed or SizeDebounce then return end

			SizeDebounce = true
			defer(function()
				SizeDebounce = false

				if not Section.Collapsed then
					local TargetHeight = Items["Content"].Instance.AbsoluteSize.Y

					if TargetHeight ~= CurrentHeight then
						CurrentHeight = TargetHeight
						Items["ContentHolder"]:Tween(TweenInfo_Fast, {
							Size = UDim2New(1, -16, 0, TargetHeight)
						})
					end
				end
			end)
		end

		UpdateSize_Connection = ListLayout.Instance:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSize)

		Items["Header"]:Connect("MouseButton1Down", function()
			Section:SetCollapsed(not Section.Collapsed)
		end)

		function Section:SetCollapsed(Bool)
			Section.Collapsed = Bool
			Items["Line"].Instance.Visible = not Section.Collapsed

			if Section.Collapsed then
				Items["Indicator"]:Tween(TweenInfo_Normal, {
					Rotation = 0,
					ImageColor3 = Library.Theme["Text"]
				})
				Items["Content"].Instance.Visible = false
				Items["ContentHolder"]:Tween(TweenInfo_Normal, {
					Size = UDim2New(1, -16, 0, 0)
				})
			else
				Items["Indicator"]:Tween(TweenInfo_Normal, {
					Rotation = 90,
					ImageColor3 = Library.Theme["Accent"]
				})
				Items["Content"].Instance.Visible = true
				Items["ContentHolder"]:Tween(TweenInfo_Normal, {
					Size = UDim2New(1, -16, 0, Items["Content"].Instance.AbsoluteSize.Y)
				})
			end
		end

		Section.Items = Items
		Section.Collapsed = Section.Collapsed
		Section:SetCollapsed(Section.Collapsed)

		table.insert(Library.AllSections, Section)
		return setmetatable(Section, Library.Sections)
	end

	Library.Pages.ModelViewerSection = function(self, Data)
		Data = Data or {}

		local Section = {
			Window = self.Window,
			Page = self,

			Name = Data.Name or Data.name or "Model Viewer",
			Side = ((Data.Side or Data.side or 1) == 2) and 2 or 1,
			Height = Data.Height or Data.height or 200,

			EnableInputCamera = Data.EnableInputCamera ~= false,
			AutoRotate = Data.AutoRotate ~= false,
			RotationSpeed = Data.RotationSpeed or Data.rotationSpeed or 0.01,
			ZoomMultiplier = Data.ZoomMultiplier or Data.zoomMultiplier or 2,
			AutoRefresh = false,
			RefreshRate = Data.RefreshRate or Data.refreshRate or 30,

			IsViewing = false,
			Items = {},
		}

		local Items = Section.Items
		local viewportFrame
		local camera
		local model
		local originalModel
		local autoRefreshThread

		local rotationX, rotationY = -0.26, 0
		local distance = 10
		local dragging = false
		local hovering = false
		local lastpos = Vector2.zero

		local function stopAutoRefresh()
			if autoRefreshThread then
				task.cancel(autoRefreshThread)
				autoRefreshThread = nil
			end
		end

		local function prepareModel(item)
			if not item or item == workspace or item:IsA("Terrain") then
				return nil
			end

			local displayModel

			if item:IsA("BasePart") and not item:IsA("Model") then
				displayModel = InstanceNew("Model")
				displayModel.Parent = viewportFrame.Instance

				local clone = item:Clone()
				clone.Parent = displayModel
				displayModel.PrimaryPart = clone

				if displayModel.SetPrimaryPartCFrame then
					displayModel:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
				else
					displayModel:PivotTo(CFrame.new(0, 0, 0))
				end
			elseif item:IsA("Model") then
				item.Archivable = true

				if #item:GetChildren() == 0 then
					return nil
				end

				displayModel = item:Clone()
				displayModel.Parent = viewportFrame.Instance

				if not displayModel.PrimaryPart then
					local found = false

					for _, child in displayModel:GetDescendants() do
						if child:IsA("BasePart") then
							displayModel.PrimaryPart = child

							if displayModel.SetPrimaryPartCFrame then
								displayModel:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
							else
								displayModel:PivotTo(CFrame.new(0, 0, 0))
							end

							found = true
							break
						end
					end

					if not found then
						displayModel:Destroy()
						return nil
					end
				end
			else
				return nil
			end

			return displayModel
		end

		Items["Section"] = Instances:Create("Frame", {
			Parent = Section.Page.ColumnsData[Section.Side].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 28),
			BackgroundColor3 = Library.Theme["Inline"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = "Inline"})

		Instances:Create("UICorner", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIGradient", {
			Parent = Items["Section"].Instance,
			Name = "\0"
		})

		Items["Text"] = Instances:Create("TextLabel", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			Size = UDim2New(0, 0, 0, 15),
			Position = UDim2New(0, 8, 0, 7),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = Section.Name,
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			AutomaticSize = Enum.AutomaticSize.X,
			ZIndex = 2
		}):AddToTheme({TextColor3 = "Text"})

		Localization:ApplyText(Items["Text"].Instance, Section.Name, "Text")

		Items["Line"] = Instances:Create("Frame", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 0, 1),
			Position = UDim2New(0, 8, 0, 28),
			BackgroundColor3 = Library.Theme["Border"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = "Border"})

		Items["ViewerHolder"] = Instances:Create("Frame", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 0, Section.Height),
			Position = UDim2New(0, 8, 0, 35),
			BackgroundColor3 = Library.Theme["Element"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = "Element"})

		Items["ViewerHolder"].Instance:SetAttribute("BlockWindowDrag", true)
		Items["ViewerHolder"].Instance.Active = true

		Instances:Create("UICorner", {
			Parent = Items["ViewerHolder"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 4)
		})

		viewportFrame = Instances:Create("ViewportFrame", {
			Parent = Items["ViewerHolder"].Instance,
			Name = "\0",
			Size = UDim2New(1, -8, 1, -8),
			Position = UDim2New(0, 4, 0, 4),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Active = true,
			ZIndex = 2,
			Ambient = FromRGB(140, 140, 140),
			LightColor = FromRGB(255, 255, 255),
			LightDirection = Vector3New(-1, -1, -1)
		})

		Instances:Create("UIPadding", {
			Parent = Items["Section"].Instance,
			Name = "\0",
			PaddingBottom = UDimNew(0, 8)
		})

		function Section:StopViewModel(updating)
			stopAutoRefresh()

			if updating then
				local existing = viewportFrame.Instance:FindFirstChildOfClass("Model")
				if existing then
					existing:Destroy()
				end
			else
				camera = nil
				model = nil
				originalModel = nil
				viewportFrame.Instance:ClearAllChildren()
				self.IsViewing = false
				Items["Text"].Instance.Text = self.Name
			end
		end

		function Section:ViewModel(item, updating)
			if not item then
				return
			end

			self:StopViewModel(updating)

			model = prepareModel(item)
			if not model or not model.PrimaryPart then
				return
			end

			originalModel = item

			if self.AutoRefresh and not updating then
				autoRefreshThread = task.spawn(function()
					while model and self.AutoRefresh and originalModel do
						self:ViewModel(originalModel, true)
						task.wait(1 / self.RefreshRate)
					end
				end)
			end

			if not updating then
				camera = InstanceNew("Camera")
				viewportFrame.Instance.CurrentCamera = camera
				camera.Parent = viewportFrame.Instance
				camera.FieldOfView = 60

				Items["Text"].Instance.Text = item.Name .. " - Preview"
				self.IsViewing = true
			end
		end

		function Section:Refresh()
			if originalModel then
				self:ViewModel(originalModel)
			end
		end

		function Section:SetAutoRotate(value)
			self.AutoRotate = value
		end

		function Section:SetAutoRefresh(value)
			self.AutoRefresh = value

			if value and originalModel then
				self:ViewModel(originalModel)
			elseif not value then
				stopAutoRefresh()
			end
		end

		function Section:SetHeight(value)
			self.Height = value
			Items["ViewerHolder"].Instance.Size = UDim2New(1, -16, 0, value)
		end

		viewportFrame:Connect("InputBegan", function(input)
			if not Section.EnableInputCamera then
				return
			end

			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Library.BlockWindowDrag = true
				dragging = true
				lastpos = input.Position
			elseif input.KeyCode == Enum.KeyCode.LeftShift then
				Section.ZoomMultiplier = 10
			end
		end)

		viewportFrame:Connect("MouseEnter", function()
			hovering = true
		end)

		viewportFrame:Connect("MouseLeave", function()
			hovering = false
		end)

		viewportFrame:Connect("InputEnded", function(input)
			if not Section.EnableInputCamera then
				return
			end

			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Library.BlockWindowDrag = false
				dragging = false
			elseif input.KeyCode == Enum.KeyCode.LeftShift then
				Section.ZoomMultiplier = 2
			end
		end)

		viewportFrame:Connect("InputChanged", function(input)
			if not Section.EnableInputCamera then
				return
			end

			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local delta = input.Position - lastpos
				lastpos = input.Position

				rotationY -= delta.X * 0.01
				rotationX -= delta.Y * 0.01
				rotationX = MathClamp(rotationX, -math.pi / 2 + 0.1, math.pi / 2 - 0.1)
			end

			if input.UserInputType == Enum.UserInputType.MouseWheel and hovering then
				distance = MathClamp(distance - (input.Position.Z * Section.ZoomMultiplier), 0.1, math.huge)
			end
		end)

		Library:Connect(RunService.RenderStepped, function(dt)
			if not camera or not model or not model.PrimaryPart then
				return
			end

			if not dragging and Section.AutoRotate then
				rotationY += Section.RotationSpeed * dt * 60
			end

			local center = model.PrimaryPart.Position
			local offset = CFrame.new(0, 0, distance)
			local rotation = CFrame.Angles(0, rotationY, 0) * CFrame.Angles(rotationX, 0, 0)
			local camCF = CFrame.new(center) * rotation * offset

			camera.CFrame = CFrame.lookAt(camCF.Position, center)
		end)

		if Data.Model or Data.model then
			Section:ViewModel(Data.Model or Data.model)
		end

		table.insert(Library.AllSections, Section)
		return setmetatable(Section, Library.Sections)
	end

	Library.Sections.Toggle = function(self, Data)
		Data = Data or {}

		local Toggle = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Data.Name or Data.name or "Toggle",
			Description = Data.Description or Data.description or nil,
			DescriptionColor = Data.DescriptionColor or Data.description_color or nil,
			Flag = Library:ResolveElementFlag(Data),
			Default = Data.Default or Data.default or false,
			Tooltip = Data.Tooltip or Data.tooltip or nil,
			Callback = Data.Callback or Data.callback or function() end,
			Lifetime = Data.Lifetime or Data.lifetime or false,

			Value = false,
			Disabled = false,
		}

		local Items = {} do 
			Items["Toggle"] = Instances:Create("Frame", {
				Parent = Toggle.Section.Items["Content"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2
			})

			Items["Toggle"]:Tooltip(Toggle.Tooltip)

			Items["Text"] = Instances:Create("TextLabel", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				Size = UDim2New(1, -96, 0, 0),
				Position = UDim2New(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Toggle.Name,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextWrapped = true,
				TextTruncate = Enum.TextTruncate.AtEnd,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})

			Items["Indicator"] = Instances:Create("TextButton", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				Size = UDim2New(0, 40, 0, 20),
				Position = UDim2New(1, 0, 0.5, 0),
				AnchorPoint = Vector2New(1, 0.5),
				BackgroundColor3 = Library.Theme["Element"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				AutoButtonColor = false,
				ZIndex = 2,
				LayoutOrder = 2
			}):AddToTheme({BackgroundColor3 = 'Element'})

			Instances:Create("UICorner", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})

			Instances:Create("UIGradient", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				Rotation = 90,
				Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
			})

			Items["Circle"] = Instances:Create("Frame", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				Size = UDim2New(0, 14, 0, 14),
				Position = UDim2New(0, 3, 0, 3),
				BackgroundTransparency = 0.4000000059604645,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 2
			})

			Instances:Create("UICorner", {
				Parent = Items["Circle"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(1, 0)
			})

			Items["SubElements"] = Instances:Create("Frame", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 0),
				Position = UDim2New(1, -40, 0.5, 0),
				AnchorPoint = Vector2New(1, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				LayoutOrder = 1
			})

			Instances:Create("UISizeConstraint", {
				Parent = Items["SubElements"].Instance,
				Name = "\0",
				MinSize = Vector2New(0, 20)
			})

			Instances:Create("UISizeConstraint", {
				Parent = Items["Toggle"].Instance,
				Name = "\0",
				MinSize = Vector2New(0, 20)
			})

			Instances:Create("UIListLayout", {
				Parent = Items["SubElements"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Center
			})

			if Toggle.Description ~= nil and Toggle.Description ~= "" then
				Items["Description"] = Instances:Create("TextLabel", {
					Parent = Items["Toggle"].Instance,
					Name = "\0",
					Size = UDim2New(1, -96, 0, 0),
					Position = UDim2New(0, 0, 0, 16.5),
					BackgroundTransparency = 1,
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Text = Toggle.Description,
					TextColor3 = Toggle.DescriptionColor or Library.Theme["Text"],
					TextSize = 12,
					FontFace = Library.Font,
					TextTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					ZIndex = 2
				})

				Library:BindDescriptionColor(Items["Description"], Toggle.DescriptionColor)
			end

			Library:BindRowTextInset(Items["Text"], Items["Description"], Items["SubElements"], 40, 8)
		end

		function Toggle:Get()
			return Toggle.Value 
		end

		function Toggle:Set(Value, Silent)
			if Toggle.Disabled then
				return
			end

			if not Library:CheckLifetime(Toggle) then
				return
			end

			Toggle.Value = Value
			if Toggle.Flag then
				Library.Flags[Toggle.Flag] = Value
			end

			local ThemeKey = Value and "Accent" or "Element"
			local TextTrans = Value and 0 or 0.4
			local CircleTrans = Value and 0 or 0.4

			Items["Text"]:Tween(nil, {TextTransparency = TextTrans})

			Items["Circle"]:Tween(TweenInfo.new(Library.Tween.Time + 0.2, Enum.EasingStyle.Quart, Library.Tween.Direction), {
				AnchorPoint = Value and Vector2New(1, 0) or Vector2New(0, 0),
				Position = Value and UDim2New(1, -3, 0, 3) or UDim2New(0, 3, 0, 3),
				BackgroundTransparency = CircleTrans,
			})

			Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = ThemeKey})
			Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme[ThemeKey]})

			if Toggle.Callback and Library:ShouldFireElementCallback(Silent) then
				Library:SafeCall(Toggle.Callback, Toggle.Value)
			end

			if Library:ShouldSaveAutoload(Silent) then
				Library:SaveAutoloadIfEnabled()
			end
		end

		function Toggle:SetDisabled(Bool)
			Toggle.Disabled = Bool

			local TextTrans = Bool and 0.6 or (Toggle.Value and 0 or 0.4)
			local CircleTrans = Bool and 0.6 or (Toggle.Value and 0 or 0.4)
			local IndicatorTrans = Bool and 0.6 or 0

			Items["Text"]:Tween(nil, {TextTransparency = TextTrans})
			Items["Circle"]:Tween(nil, {BackgroundTransparency = CircleTrans})
			Items["Indicator"]:Tween(nil, {BackgroundTransparency = IndicatorTrans})
		end

		function Toggle:SetVisibility(Bool)
			Items["Toggle"].Instance.Visible = Bool 
		end

		function Toggle:Colorpicker(Data)
			Data = Data or {}

			local Colorpicker = {
				Window = Toggle.Window,
				Page = Toggle.Page,
				Section = Toggle.Section,

				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
				Callback = Data.Callback or Data.callback or function() end,
				Alpha = Data.Alpha or Data.alpha or false
			}

			local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
				Parent = Items["SubElements"],
				Page = Colorpicker.Page,
				Section = Colorpicker.Section,
				Flag = Colorpicker.Flag,
				Default = Colorpicker.Default,
				Callback = Colorpicker.Callback,
				Alpha = Colorpicker.Alpha
			})

			return NewColorpicker
		end

		function Toggle:Keybind(Data)
			Data = Data or {}

			local Keybind = {
				Window = Toggle.Window,
				Page = Toggle.Page,
				Section = Toggle.Section,

				Name = Data.Name or Data.name or Toggle.Name,
				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or KEYBIND_NONE_KEY,
				Callback = Data.Callback or Data.callback or function() end,
				Mode = Data.Mode or Data.mode or "Toggle"
			}

			local NewKeybind, KeybindItems = Library:CreateKeybind({
				Parent = Items["SubElements"],
				Page = Keybind.Page,
				Section = Keybind.Section,
				Flag = Keybind.Flag,
				Name = Keybind.Name,
				Default = Keybind.Default,
				Mode = Keybind.Mode,
				Callback = Keybind.Callback
			})

			return NewKeybind
		end

		local PageSearchData = Library.SearchItems[Toggle.Page] 

		if PageSearchData then
			local SearchData = { 
				Element = Items["Toggle"],
				Name = Toggle.Name,
			}

			TableInsert(PageSearchData, SearchData)
		end

		Items["Indicator"]:Connect("MouseButton1Down", function()
			Toggle:Set(not Toggle.Value)
		end)

		Toggle:Set(Toggle.Default, true)

		Library:BindElementFlag(Toggle.Flag, function(Value)
			if Toggle.Disabled then
				return
			end

			Toggle:Set(Value, Library.LoadingConfig == true)
		end, Toggle)

		function Toggle:Destroy()
			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			return Toggle
		end

		Toggle.Items = Items
		return Toggle 
	end

	Library.Sections.Checkbox = function(self, Data)
		Data = Data or {}

		local Checkbox = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Data.Name or Data.name or "Checkbox",
			Description = Data.Description or Data.description or nil,
			DescriptionColor = Data.DescriptionColor or Data.description_color or nil,
			Flag = Library:ResolveElementFlag(Data),
			Default = Data.Default or Data.default or false,
			Tooltip = Data.Tooltip or Data.tooltip or nil,
			Callback = Data.Callback or Data.callback or function() end,
			Lifetime = Data.Lifetime or Data.lifetime or false,

			Value = false,
			Disabled = false,
		}

		local Items = {} do 
			Items["Checkbox"] = Instances:Create("Frame", {
				Parent = Checkbox.Section.Items["Content"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2
			})

			Items["Checkbox"]:Tooltip(Checkbox.Tooltip)

			Items["Text"] = Instances:Create("TextLabel", {
				Parent = Items["Checkbox"].Instance,
				Name = "\0",
				Size = UDim2New(1, -96, 0, 0),
				Position = UDim2New(0, 0, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Checkbox.Name,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2
			}):AddToTheme({TextColor3 = 'Text'})

			if Checkbox.Description ~= nil and Checkbox.Description ~= "" then
				Items["Description"] = Instances:Create("TextLabel", {
					Parent = Items["Checkbox"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 0, 0),
					Position = UDim2New(0, 0, 0, 16.5),
					AnchorPoint = Vector2New(0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Text = Checkbox.Description,
					TextColor3 = Checkbox.DescriptionColor or Library.Theme["Text"],
					TextSize = 12,
					FontFace = Library.Font,
					TextTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					ZIndex = 2
				})

				Library:BindDescriptionColor(Items["Description"], Checkbox.DescriptionColor)
			end

			Items["Indicator"] = Instances:Create("TextButton", {
				Parent = Items["Checkbox"].Instance,
				Name = "\0",
				Size = UDim2New(0, 20, 0, 20),
				Position = UDim2New(1, 0, 0.5, 0),
				AnchorPoint = Vector2New(1, 0.5),
				BackgroundColor3 = Library.Theme["Element"],
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				AutoButtonColor = false,
				ZIndex = 2
			}):AddToTheme({BackgroundColor3 = 'Element'})

			Instances:Create("UICorner", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Instances:Create("UIGradient", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				Rotation = 90,
				Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
			})

			Items["Check"] = Instances:Create("ImageLabel", {
				Parent = Items["Indicator"].Instance,
				Name = "\0",
				Size = UDim2New(1, -2, 1, -2),
				Position = UDim2New(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2New(0.5, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://116339777575852",
				ImageColor3 = FromRGB(0, 0, 0),
				ImageTransparency = 1,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 2
			})

			Items["SubElements"] = Instances:Create("Frame", {
				Parent = Items["Checkbox"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 0),
				Position = UDim2New(1, -20, 0.5, 0),
				AnchorPoint = Vector2New(1, 0.5),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				LayoutOrder = 1
			})

			Instances:Create("UIListLayout", {
				Parent = Items["SubElements"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Center
			})

			Library:BindRowTextInset(Items["Text"], Items["Description"], Items["SubElements"], 20, 8)
		end

		function Checkbox:Get()
			return Checkbox.Value
		end

		function Checkbox:Set(Value, Silent)
			if Checkbox.Disabled then
				return
			end

			if not Library:CheckLifetime(Checkbox) then
				return
			end

			Checkbox.Value = Value
			if Checkbox.Flag then
				Library.Flags[Checkbox.Flag] = Checkbox.Value
			end

			local ThemeKey = Value and "Accent" or "Element"
			local TextTrans = Value and 0 or 0.4
			local CheckTrans = Value and 0 or 1

			Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = ThemeKey})
			Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme[ThemeKey]})
			Items["Check"]:Tween(nil, {ImageTransparency = CheckTrans})
			Items["Text"]:Tween(nil, {TextTransparency = TextTrans})

			if Checkbox.Callback and Library:ShouldFireElementCallback(Silent) then
				Library:SafeCall(Checkbox.Callback, Checkbox.Value)
			end

			if Library:ShouldSaveAutoload(Silent) then
				Library:SaveAutoloadIfEnabled()
			end
		end

		function Checkbox:SetDisabled(Bool)
			Checkbox.Disabled = Bool

			local TextTrans = Bool and 0.6 or (Checkbox.Value and 0 or 0.4)
			local IndicatorTrans = Bool and 0.6 or 0
			local CheckTrans = Bool and 1 or (Checkbox.Value and 0 or 1)

			Items["Text"]:Tween(nil, {TextTransparency = TextTrans})
			Items["Indicator"]:Tween(nil, {BackgroundTransparency = IndicatorTrans})
			Items["Check"]:Tween(nil, {ImageTransparency = CheckTrans})
		end

		function Checkbox:SetVisibility(Bool)
			Items["Checkbox"].Instance.Visible = Bool
		end

		function Checkbox:Colorpicker(Data)
			Data = Data or {}

			local Colorpicker = {
				Window = Checkbox.Window,
				Page = Checkbox.Page,
				Section = Checkbox.Section,

				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
				Callback = Data.Callback or Data.callback or function() end,
				Alpha = Data.Alpha or Data.alpha or false
			}

			local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
				Parent = Items["SubElements"],
				Page = Colorpicker.Page,
				Section = Colorpicker.Section,
				Flag = Colorpicker.Flag,
				Default = Colorpicker.Default,
				Callback = Colorpicker.Callback,
				Alpha = Colorpicker.Alpha
			})

			return NewColorpicker
		end

		function Checkbox:Keybind(Data)
			Data = Data or {}

			local Keybind = {
				Window = Checkbox.Window,
				Page = Checkbox.Page,
				Section = Checkbox.Section,

				Name = Data.Name or Data.name or Checkbox.Name,
				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or KEYBIND_NONE_KEY,
				Callback = Data.Callback or Data.callback or function() end,
				Mode = Data.Mode or Data.mode or "Toggle"
			}

			local NewKeybind, KeybindItems = Library:CreateKeybind({
				Parent = Items["SubElements"],
				Page = Keybind.Page,
				Section = Keybind.Section,
				Flag = Keybind.Flag,
				Name = Keybind.Name,
				Default = Keybind.Default,
				Mode = Keybind.Mode,
				Callback = Keybind.Callback
			})

			return NewKeybind
		end

		local PageSearchData = Library.SearchItems[Checkbox.Page]

		if PageSearchData then
			local SearchData = {
				Element = Items["Checkbox"],
				Name = Checkbox.Name,
			}

			TableInsert(PageSearchData, SearchData)
		end

		Items["Indicator"]:Connect("InputBegan", function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Checkbox:Set(not Checkbox.Value)
			end
		end)

		Checkbox:Set(Checkbox.Default, true)

		Library:BindElementFlag(Checkbox.Flag, function(Value)
			Checkbox:Set(Value, Library.LoadingConfig == true)
		end, Checkbox)

		function Checkbox:Destroy()
			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			return Checkbox
		end

		Checkbox.Items = Items
		return Checkbox
	end

	Library.Sections.Button = function(self, Data)
		Data = type(Data) == "table" and Data or {}

		local Button = {
			Window = self.Window,
			Page = self.Page,
			Section = self,
		}

		local Items = {}

		Items["ButtonContainer"] = Instances:Create("Frame", {
			Parent = Button.Section.Items["Content"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		})

		Instances:Create("UIListLayout", {
			Parent = Items["ButtonContainer"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = Enum.UIFlexAlignment.Fill
		})

		function Button:Add(Name, Callback, Data)
			Data = Data or {}

			local NewButton = {
				Disabled = false,
				Lifetime = Data.Lifetime or Data.lifetime or false
			}

			local NewItems = {}
			do
				NewItems["NewButton"] = Instances:Create("TextButton", {
					Parent = Items["ButtonContainer"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 0, 22),
					BackgroundColor3 = Library.Theme["Element"],
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Text = "",
					TextColor3 = FromRGB(0, 0, 0),
					TextSize = 14,
					FontFace = Library.Font,
					AutoButtonColor = false,
					ZIndex = 2
				}):AddToTheme({BackgroundColor3 = 'Element'})

				Instances:Create("UICorner", {
					Parent = NewItems["NewButton"].Instance,
					Name = "\0",
					CornerRadius = UDimNew(0, 5)
				})

				Instances:Create("UIGradient", {
					Parent = NewItems["NewButton"].Instance,
					Name = "\0",
					Rotation = 90,
					Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
				})

				NewItems["Text"] = Instances:Create("TextLabel", {
					Parent = NewItems["NewButton"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 1, 0),
					BackgroundTransparency = 1,
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Text = Name,
					TextColor3 = Library.Theme["Text"],
					TextSize = 14,
					FontFace = Library.Font,
					ZIndex = 2
				}):AddToTheme({TextColor3 = 'Text'})
			end

			function NewButton:SetVisibility(Bool)
				NewItems["NewButton"].Instance.Visible = Bool
				Items["ButtonContainer"].Instance.Visible = Bool
			end

			function NewButton:Press()
				if NewButton.Disabled then
					return
				end

				if not Library:CheckLifetime(NewButton) then
					return
				end

				if not Library:CheckLifetime(NewButton) then
					return
				end

				NewItems["NewButton"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
				NewItems["NewButton"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
				wait(0.1)
				Library:SafeCall(Callback)
				NewItems["NewButton"]:ChangeItemTheme({BackgroundColor3 = "Element"})
				NewItems["NewButton"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
			end

			function NewButton:SetDisabled(Bool)
				NewButton.Disabled = Bool

				if NewButton.Disabled then
					NewItems["NewButton"]:Tween(nil, {BackgroundTransparency = 0.6})
					NewItems["Text"]:Tween(nil, {TextTransparency = 0.6})
				else
					NewItems["NewButton"]:Tween(nil, {BackgroundTransparency = 0})
					NewItems["Text"]:Tween(nil, {TextTransparency = 0})
				end
			end

			local PageSearchData = Library.SearchItems[Button.Page]

			if PageSearchData then
				local SearchData = {
					Element = NewItems["NewButton"],
					Element2 = Items["ButtonContainer"],
					Name = Name,
					Type = "Button",
				}

				TableInsert(PageSearchData, SearchData)
			end

			NewItems["NewButton"]:Connect("MouseButton1Down", function()
				NewButton:Press()
			end)

			NewButton.Items = NewItems
			return Button, NewButton
		end

		function Button:SetVisibility(Bool)
			Items["ButtonContainer"].Instance.Visible = Bool
		end

		function Button:Destroy()
			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end
			return Button
		end

		Button.Items = Items

		if Data.Name or Data.name then
			local _, NewButton = Button:Add(Data.Name or Data.name, Data.Callback or Data.callback, Data)
			return NewButton
		end

		return Button
	end

	Library.Sections.Slider = function(self, Data)
		Data = Data or {}

		local Min = Data.Min or Data.min or 0
		local Max = Data.Max or Data.max or 100
		local Decimals = Data.Decimals or Data.decimals
		local AutoDecimals = (Decimals == nil)

		local SuggestedDecimals = 0
		local Range = Max - Min
		if Range <= 1 then
			SuggestedDecimals = 2
		elseif Range <= 10 then
			SuggestedDecimals = 1
		elseif Range <= 100 then
			SuggestedDecimals = 0
		else
			SuggestedDecimals = math.max(math.ceil(math.log10(Range)) - 2, 0)
		end

		local Compact = Data.Compact ~= false

		local Slider = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Data.Name or Data.name or "Slider",
			Compact = Compact,
			Description = Data.Description or Data.description or nil,
			DescriptionColor = Data.DescriptionColor or Data.description_color or nil,
			Flag = Library:ResolveElementFlag(Data),
			Min = Min,
			Default = Data.Default or Data.default or Min,
			Max = Max,
			Suffix = Data.Suffix or Data.suffix or "",
			Tooltip = Data.Tooltip or Data.tooltip or nil,
			Decimals = Decimals,
			DisplayDecimals = AutoDecimals and SuggestedDecimals or 0,
			Callback = Data.Callback or Data.callback or function() end,
			Lifetime = Data.Lifetime or Data.lifetime or false,

			Value = 0,
			Sliding = false,
			Disabled = false,
			InputChangedConnection = nil,
		}

		local Items = {}

		Items["SliderContainer"] = Instances:Create("Frame", {
			Parent = Slider.Section.Items["Content"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		})

		Instances:Create("UIListLayout", {
			Parent = Items["SliderContainer"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top
		})

		Items["Text"] = Instances:Create("TextLabel", {
			Parent = Items["SliderContainer"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 15),
			Position = UDim2New(0, 0, 0, 0),
			AnchorPoint = Vector2New(0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = Slider.Name,
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextWrapped = true,
			ZIndex = 4,
			LayoutOrder = 0
		}):AddToTheme({TextColor3 = 'Text'})

		if Slider.Compact then
			Items["Text"].Instance.Visible = false
			Items["Text"].Instance.Size = UDim2New(1, 0, 0, 0)
		end

		if not Slider.Compact and Slider.Description ~= nil and Slider.Description ~= "" then
			Items["Description"] = Instances:Create("TextLabel", {
				Parent = Items["SliderContainer"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				Position = UDim2New(0, 0, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Slider.Description,
				TextColor3 = Slider.DescriptionColor or Library.Theme["Text"],
				TextSize = 12,
				FontFace = Library.Font,
				TextTransparency = 0.5,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 4,
				LayoutOrder = 1
			})

			Library:BindDescriptionColor(Items["Description"], Slider.DescriptionColor)
		end

		Items["SliderRow"] = Instances:Create("Frame", {
			Parent = Items["SliderContainer"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, Slider.Compact and 22 or 15),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.None,
			ZIndex = 2,
			LayoutOrder = 2
		})

		Instances:Create("UIListLayout", {
			Parent = Items["SliderRow"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Center
		})

		Items["ValueBackground"] = Instances:Create("Frame", {
			Parent = Items["SliderRow"].Instance,
			Name = "\0",
			Size = UDim2New(0, 55, 1, 0),
			BackgroundColor3 = Library.Theme["Element"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ClipsDescendants = false,
			ZIndex = 3,
			LayoutOrder = 1
		}):AddToTheme({BackgroundColor3 = 'Element'})

		Instances:Create("UICorner", {
			Parent = Items["ValueBackground"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Items["Value"] = Instances:Create("TextBox", {
			Parent = Items["ValueBackground"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 1, 0),
			Position = UDim2New(0, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = StringFormat("%s%s", Slider.Value, Slider.Suffix),
			TextColor3 = Library.Theme["Text"],
			TextSize = 12,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextScaled = false,
			PlaceholderColor3 = Library.Theme["Inactive Text"],
			ClearTextOnFocus = false,
			CursorPosition = -1,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextWrapped = false,
			ZIndex = 4
		}):AddToTheme({TextColor3 = 'Text'})

		Items["RealSlider"] = Instances:Create("TextButton", {
			Parent = Items["SliderRow"].Instance,
			Name = "\0",
			Size = UDim2New(1, -60, 1, 0),
			BackgroundColor3 = Library.Theme["Element"],
			BackgroundTransparency = 0,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			ClipsDescendants = true,
			AutoButtonColor = false,
			Active = false,
			Selectable = false,
			ZIndex = 2,
			LayoutOrder = 0
		}):AddToTheme({BackgroundColor3 = 'Element'})

		Instances:Create("UIFlexItem", {
			Parent = Items["RealSlider"].Instance,
			Name = "\0",
			FlexMode = Enum.UIFlexMode.Fill,
		})

		Instances:Create("UICorner", {
			Parent = Items["RealSlider"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIGradient", {
			Parent = Items["RealSlider"].Instance,
			Name = "\0",
			Rotation = 90,
			Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
		})

		Items["Accent"] = Instances:Create("Frame", {
			Parent = Items["RealSlider"].Instance,
			Name = "\0",
			Size = UDim2New(0.5, 0, 1, 0),
			BackgroundColor3 = Library.Theme["Accent"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Accent'})

		Instances:Create("UIGradient", {
			Parent = Items["Accent"].Instance,
			Name = "\0",
			Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(163, 163, 163))}
		})

		Instances:Create("UICorner", {
			Parent = Items["Accent"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		if Slider.Compact then
			Items["TrackLabel"] = Instances:Create("TextLabel", {
				Parent = Items["RealSlider"].Instance,
				Name = "\0",
				Size = UDim2New(1, -12, 1, 0),
				Position = UDim2New(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = Library.Theme["Text"],
				TextSize = 13,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				ZIndex = 8,
			}):AddToTheme({TextColor3 = "Text"})

			Instances:Create("UIPadding", {
				Parent = Items["TrackLabel"].Instance,
				Name = "\0",
				PaddingLeft = UDimNew(0, 8),
				PaddingRight = UDimNew(0, 10),
			})

			Instances:Create("UIStroke", {
				Parent = Items["TrackLabel"].Instance,
				Name = "\0",
				Thickness = 1,
				Color = FromRGB(0, 0, 0),
				Transparency = 0.35,
			})
		end

		Items["Drag"] = Instances:Create("Frame", {
			Parent = Items["Accent"].Instance,
			Name = "\0",
			Size = UDim2New(0, 7, 1, 0),
			Position = UDim2New(1, 0, 0.5, 0),
			AnchorPoint = Vector2New(1, 0.5),
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ZIndex = 5
		})

		Instances:Create("UICorner", {
			Parent = Items["Drag"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		if Slider.Compact then
			Items["ValueBackground"]:Tooltip(Slider.Tooltip)
		else
			Items["Text"]:Tooltip(Slider.Tooltip)
		end

		local SliderFocused = false

		Items["Value"]:Connect("Focused", function()
			if Slider.Disabled then
				return
			end

			SliderFocused = true

			local Stripped = StringGSub(Items["Value"].Instance.Text, "[^0-9%.%-]", "")

			Items["Value"].Instance.Text = Stripped
		end)

		local function ApplyValueInputText(LiveUpdate)
			if Slider.Disabled then
				return
			end

			local Text = Items["Value"].Instance.Text
			local Stripped = StringGSub(Text, "[^0-9%.%-]", "")
			local NumValue = tonumber(Stripped)

			if LiveUpdate and Stripped ~= Text then
				Items["Value"].Instance.Text = Stripped
				Text = Stripped
			end

			if NumValue then
				Slider:Set(NumValue, LiveUpdate)
				Items["Value"].Instance.TextColor3 = Library.Theme["Text"]
				return true
			end

			if Text ~= "" then
				Items["Value"].Instance.TextColor3 = FromRGB(255, 80, 80)
			else
				Items["Value"].Instance.TextColor3 = Library.Theme["Text"]
			end

			return false
		end

		Items["Value"]:Connect("focusLost", function()
			if Slider.Disabled then
				return
			end

			SliderFocused = false

			local Text = Items["Value"].Instance.Text
			local Stripped = StringGSub(Text, "[^0-9%.%-]", "")
			local NumValue = tonumber(Stripped)

			if NumValue then
				Slider:Set(NumValue)
			else
				Slider:Set(Slider.Value)
			end
		end)

		Items["Value"]:Connect("Changed", function(Property)
			if Property == "Text" and SliderFocused then
				ApplyValueInputText(true)
			end
		end)

		Library.SliderElements[Slider] = {
			Slider = Items["SliderContainer"],
			RealSlider = Items["RealSlider"],
			Accent = Items["Accent"],
			Drag = Items["Drag"]
		}

		if Slider.Compact and Items["TrackLabel"] and Items["TrackLabel"].Instance then
			Library.Localization:RegisterSlider(Slider, Items["TrackLabel"].Instance, Slider.Name, Slider.Suffix or "")
		end

		function Slider:Get()
			return Slider.Value
		end

		function Slider:SetVisibility(Bool)
			Items["SliderContainer"].Instance.Visible = Bool
		end

		function Slider:Set(Value, SkipTextUpdate, Silent)
			if Slider.Disabled then
				return
			end

			if not Library:CheckLifetime(Slider) then
				return
			end

			local ClampedValue = MathClamp(Value, Slider.Min, Slider.Max)

			if Slider.Decimals then
				local Offset = ClampedValue - Slider.Min
				local StepFrac = Offset / Slider.Decimals
				local NearestStep = MathFloor(StepFrac + 0.5)

				Slider.Value = Slider.Min + NearestStep * Slider.Decimals
				Slider.Value = MathClamp(Slider.Value, Slider.Min, Slider.Max)
			else
				Slider.Value = Library:Round(ClampedValue, Slider.DisplayDecimals or 0)
				Slider.Value = MathClamp(Slider.Value, Slider.Min, Slider.Max)
			end

			if Slider.Flag then
				Library.Flags[Slider.Flag] = Slider.Value
			end

			local slider_range = Slider.Max - Slider.Min
			local slider_ratio = slider_range > 0 and (Slider.Value - Slider.Min) / slider_range or 0
			slider_ratio = MathClamp(slider_ratio, 0, 1)

			if slider_ratio <= 0.001 then
				pcall(function()
					Items["Accent"].Instance.Visible = false
					Items["Accent"].Instance.Size = UDim2New(0, 0, 1, 0)
				end)
			else
				pcall(function()
					Items["Accent"].Instance.Visible = true
				end)
				Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New(slider_ratio, 0, 1, 0)})
			end

			if not SkipTextUpdate and Items["Value"] and Items["Value"].Instance then
				pcall(function()
					local DisplayValue = string.format("%g", Slider.Value)
					Items["Value"].Instance.Text = StringFormat("%s%s", DisplayValue, Slider.Suffix)
				end)
			end

			if Slider.Compact and Items["TrackLabel"] and Items["TrackLabel"].Instance then
				Library.Localization:UpdateSliderTrackLabel(Slider, Items["TrackLabel"].Instance, Slider.Name, Slider.Suffix)
			end

			if Slider.Callback and Library:ShouldFireElementCallback(Silent) then
				Library:SafeCall(Slider.Callback, Slider.Value)
			end

			if Library:ShouldSaveAutoload(Silent) then
				Library:SaveAutoloadIfEnabled()
			end
		end

		function Slider:SetDisabled(Bool)
			Slider.Disabled = Bool

			if Slider.Disabled then
				Items["RealSlider"]:Tween(nil, {BackgroundTransparency = 0.6})
				Items["Accent"]:Tween(nil, {BackgroundTransparency = 0.6})
				Items["Value"]:Tween(nil, {TextTransparency = 0.6})
				Items["ValueBackground"]:Tween(nil, {BackgroundTransparency = 0.6})
				if Slider.Compact and Items["TrackLabel"] then
					Items["TrackLabel"]:Tween(nil, {TextTransparency = 0.6})
				end
			else
				Items["RealSlider"]:Tween(nil, {BackgroundTransparency = 0})
				Items["Accent"]:Tween(nil, {BackgroundTransparency = 0})
				Items["Value"]:Tween(nil, {TextTransparency = 0})
				Items["ValueBackground"]:Tween(nil, {BackgroundTransparency = 0})
				if Slider.Compact and Items["TrackLabel"] then
					Items["TrackLabel"]:Tween(nil, {TextTransparency = 0})
				end
			end
		end

		local PageSearchData = Library.SearchItems[Slider.Page]

		if PageSearchData then
			local SearchData = {
				Element = Items["SliderContainer"],
				Name = Slider.Name,
			}

			TableInsert(PageSearchData, SearchData)
		end

		local function UpdateSliderValue()
			if Slider.Disabled or not Slider.Sliding then
				return
			end

			local MouseLocation = GetMouseLocation()
			local SliderAbs = Items["RealSlider"].Instance.AbsolutePosition
			local SliderSize = Items["RealSlider"].Instance.AbsoluteSize
			local SizeX = MathClamp((MouseLocation.X - SliderAbs.X) / SliderSize.X, 0, 1)
			local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

			Slider:Set(Value)
		end

		Items["RealSlider"]:Connect("InputBegan", function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Slider.Disabled then
					return
				end

				Slider.Sliding = true

				local MouseLocation = GetMouseLocation()
				local SliderAbs = Items["RealSlider"].Instance.AbsolutePosition
				local SliderSize = Items["RealSlider"].Instance.AbsoluteSize
				local SizeX = MathClamp((MouseLocation.X - SliderAbs.X) / SliderSize.X, 0, 1)
				local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

				Slider:Set(Value)

				Slider.InputChangedConnection = Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Slider.Sliding = false
						Slider.InputChangedConnection:Disconnect()
						Slider.InputChangedConnection = nil
					end
				end)
			end
		end)

		Slider.InputChangedConnection = Library:Connect(UserInputService.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				UpdateSliderValue()
			end
		end)

		if Slider.Default then
			Slider:Set(Slider.Default, false, true)
		end

		Library:BindElementFlag(Slider.Flag, function(Value)
			if Slider.Disabled then
				return
			end
			Slider:Set(Value, false, Library.LoadingConfig == true)
		end, Slider)

		function Slider:Destroy()
			if Slider.InputChangedConnection then
				Slider.InputChangedConnection:Disconnect()
				Slider.InputChangedConnection = nil
			end

			if Library.SliderElements[Slider] then
				Library.SliderElements[Slider] = nil
			end

			if Library.SetFlags[Slider.Flag] then
				Library.SetFlags[Slider.Flag] = nil
			end

			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			return Slider
		end

		Slider.Items = Items
		return Slider
	end

	Library.Sections.SubSlider = function(self, Data)
		Data = Data or {}

		local SubSlider = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Data.Name or Data.name or nil,
			Description = Data.Description or Data.description or nil,
			DescriptionColor = Data.DescriptionColor or Data.description_color or nil,
			Tooltip = Data.Tooltip or Data.tooltip or nil,
			Compact = Data.Compact == true or Data.compact == true,

			Entries = {},
			SlidingEntry = nil,
			SlidingKind = nil,
		}

		local Items = {}
		local TRACK_HEIGHT = 22
		local COMPACT_TRACK_WIDTH = 80
		local RANGE_GAP = 6
		local BLOCK_GAP = 8

		Items["SubSliderContainer"] = Instances:Create("Frame", {
			Parent = SubSlider.Section.Items["Content"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2,
		})

		Instances:Create("UIListLayout", {
			Parent = Items["SubSliderContainer"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
		})

		Items["SubSliderRow"] = Instances:Create("Frame", {
			Parent = Items["SubSliderContainer"].Instance,
			Name = "\0",
			Size = SubSlider.Compact and UDim2New(0, 0, 0, 0) or UDim2New(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AutomaticSize = SubSlider.Compact and Enum.AutomaticSize.XY or Enum.AutomaticSize.Y,
			ZIndex = 2,
			LayoutOrder = 0,
		})

		Instances:Create("UIListLayout", {
			Parent = Items["SubSliderRow"].Instance,
			Name = "\0",
			Padding = UDimNew(0, BLOCK_GAP),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = SubSlider.Compact and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalFlex = SubSlider.Compact and Enum.UIFlexAlignment.None or Enum.UIFlexAlignment.Fill,
			VerticalFlex = SubSlider.Compact and Enum.UIFlexAlignment.None or Enum.UIFlexAlignment.Fill,
		})

		local function FormatSpeed(Entry, Value)
			return string.format("%g", Value) .. Entry.SpeedSuffix
		end

		local function FormatRangeLabel(RangeName, Value, Suffix)
			local LabelPrefix = string.lower(RangeName or "value") .. ": "
			return LabelPrefix .. string.format("%g", Value) .. (Suffix or "")
		end

		local function ClampSpeed(Entry, Value)
			local Clamped = MathClamp(Value, Entry.SpeedMin, Entry.SpeedMax)

			if Entry.SpeedDecimals then
				local Offset = Clamped - Entry.SpeedMin
				local StepFrac = Offset / Entry.SpeedDecimals
				local NearestStep = MathFloor(StepFrac + 0.5)

				Clamped = Entry.SpeedMin + NearestStep * Entry.SpeedDecimals
				Clamped = MathClamp(Clamped, Entry.SpeedMin, Entry.SpeedMax)
			else
				Clamped = Library:Round(Clamped, 0)
			end

			return Clamped
		end

		local function ClampRange(Entry, Value, Min, Max)
			local Clamped = MathClamp(Value, Min, Max)

			if Entry.RangeDecimals then
				local Offset = Clamped - Min
				local StepFrac = Offset / Entry.RangeDecimals
				local NearestStep = MathFloor(StepFrac + 0.5)

				Clamped = Min + NearestStep * Entry.RangeDecimals
				Clamped = MathClamp(Clamped, Min, Max)
			else
				Clamped = Library:Round(Clamped, 0)
			end

			return Clamped
		end

		local function UpdateEntryFlags(Entry)
			Library.Flags[Entry.Flag] = {
				Speed = Entry.Speed,
				Start = Entry.Start,
				["End"] = Entry["End"],
			}
		end

		local function FormatSpeedLabel(Entry, Value)
			local LabelPrefix = string.lower(Entry.Name or "value") .. ": "
			return LabelPrefix .. string.format("%g", Value) .. Entry.SpeedSuffix
		end

		local function RefreshSpeedVisual(Entry)
			local EntryItems = Entry.Items
			local Alpha = (Entry.Speed - Entry.SpeedMin) / (Entry.SpeedMax - Entry.SpeedMin)

			EntryItems["SpeedAccent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2New(MathClamp(Alpha, 0, 1), 0, 1, 0),
			})
			EntryItems["SpeedLabel"].Instance.Text = FormatSpeedLabel(Entry, Entry.Speed)
		end

		local function RefreshStartVisual(Entry)
			local EntryItems = Entry.Items
			local Alpha = (Entry.Start - Entry.StartMin) / (Entry.StartMax - Entry.StartMin)

			EntryItems["StartAccent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2New(MathClamp(Alpha, 0, 1), 0, 1, 0),
			})
			EntryItems["StartLabel"].Instance.Text = FormatRangeLabel("start", Entry.Start, Entry.StartSuffix)
		end

		local function RefreshEndVisual(Entry)
			local EntryItems = Entry.Items
			local Alpha = (Entry["End"] - Entry.EndMin) / (Entry.EndMax - Entry.EndMin)

			EntryItems["EndAccent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Size = UDim2New(MathClamp(Alpha, 0, 1), 0, 1, 0),
			})
			EntryItems["EndLabel"].Instance.Text = FormatRangeLabel("end", Entry["End"], Entry.EndSuffix)
		end

		local function FireEntryCallback(Entry, Silent)
			if Entry.Callback and Library:ShouldFireElementCallback(Silent) then
				Library:SafeCall(Entry.Callback, Entry.Speed, Entry.Start, Entry["End"])
			end
		end

		local function EntrySet(Entry, Value, Silent)
			if Entry.Disabled then
				return
			end

			if not Library:CheckLifetime(Entry) then
				return
			end

			if type(Value) == "table" then
				if Value.Speed ~= nil then
					Entry.Speed = ClampSpeed(Entry, Value.Speed)
				end

				if Value.Start ~= nil then
					Entry.Start = ClampRange(Entry, Value.Start, Entry.StartMin, Entry.StartMax)
				end

				if Value["End"] ~= nil or Value.End ~= nil then
					Entry["End"] = ClampRange(Entry, Value["End"] or Value.End, Entry.EndMin, Entry.EndMax)
				end
			end

			UpdateEntryFlags(Entry)
			RefreshSpeedVisual(Entry)
			if not Entry.HideRange then
				RefreshStartVisual(Entry)
				RefreshEndVisual(Entry)
			end
			FireEntryCallback(Entry, Silent)
			if Library:ShouldSaveAutoload(Silent) then
				Library:SaveAutoloadIfEnabled()
			end
		end

		local function CreateTrack(Parent, LayoutOrder, ZIndex, Size)
			local TrackItems = {}

			TrackItems["Track"] = Instances:Create("TextButton", {
				Parent = Parent,
				Name = "\0",
				Size = Size or UDim2New(1, 0, 0, TRACK_HEIGHT),
				BackgroundColor3 = Library.Theme["Element"],
				BorderSizePixel = 0,
				Text = "",
				ClipsDescendants = false,
				AutoButtonColor = false,
				ZIndex = ZIndex,
				LayoutOrder = LayoutOrder,
			}):AddToTheme({BackgroundColor3 = "Element"})

			Instances:Create("UICorner", {
				Parent = TrackItems["Track"].Instance,
				CornerRadius = UDimNew(0, 5),
			})

			TrackItems["Accent"] = Instances:Create("Frame", {
				Parent = TrackItems["Track"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 1, 0),
				BackgroundColor3 = Library.Theme["Accent"],
				BorderSizePixel = 0,
				ZIndex = ZIndex + 1,
			}):AddToTheme({BackgroundColor3 = "Accent"})

			Instances:Create("UICorner", {
				Parent = TrackItems["Accent"].Instance,
				CornerRadius = UDimNew(0, 5),
			})

			TrackItems["Label"] = Instances:Create("TextLabel", {
				Parent = TrackItems["Track"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = Library.Theme["Text"],
				TextSize = 13,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Center,
				ZIndex = ZIndex + 3,
			}):AddToTheme({TextColor3 = "Text"})

			Instances:Create("UIStroke", {
				Parent = TrackItems["Label"].Instance,
				Name = "\0",
				Thickness = 1,
				Color = FromRGB(0, 0, 0),
				Transparency = 0.35,
			})

			return TrackItems
		end

		local function UpdateEntryFromInput(Entry, Kind)
			if Entry.Disabled or SubSlider.SlidingEntry ~= Entry or SubSlider.SlidingKind ~= Kind then
				return
			end

			local EntryItems = Entry.Items
			local TrackButton

			if Kind == "Speed" then
				TrackButton = EntryItems["SpeedButton"].Instance
			elseif Kind == "Start" then
				TrackButton = EntryItems["StartButton"].Instance
			else
				TrackButton = EntryItems["EndButton"].Instance
			end

			local MouseLocation = GetMouseLocation()
			local TrackAbs = TrackButton.AbsolutePosition
			local TrackSize = TrackButton.AbsoluteSize
			local SizeX = MathClamp((MouseLocation.X - TrackAbs.X) / TrackSize.X, 0, 1)

			if Kind == "Speed" then
				Entry.Speed = ClampSpeed(Entry, Entry.SpeedMin + (Entry.SpeedMax - Entry.SpeedMin) * SizeX)
				RefreshSpeedVisual(Entry)
			elseif Kind == "Start" then
				Entry.Start = ClampRange(Entry, Entry.StartMin + (Entry.StartMax - Entry.StartMin) * SizeX, Entry.StartMin, Entry.StartMax)
				RefreshStartVisual(Entry)
			else
				Entry["End"] = ClampRange(Entry, Entry.EndMin + (Entry.EndMax - Entry.EndMin) * SizeX, Entry.EndMin, Entry.EndMax)
				RefreshEndVisual(Entry)
			end

			UpdateEntryFlags(Entry)
			FireEntryCallback(Entry)
		end

		function SubSlider:Add(Data)
			Data = Data or {}

			local Entry = {
				Window = SubSlider.Window,
				Page = SubSlider.Page,
				Section = SubSlider.Section,

				Name = Data.Name or Data.name or "value",
				Flag = Library:ResolveElementFlag(Data),
				Lifetime = Data.Lifetime or Data.lifetime or false,
				HideRange = Data.HideRange == true or Data.hide_range == true,

				Speed = Data.SpeedDefault or Data.speed_default or Data.DefaultSpeed or Data.Default or Data.default or 1,
				Start = Data.StartDefault or Data.start_default or 0,
				["End"] = Data.EndDefault or Data.end_default or 100,

				SpeedMin = Data.SpeedMin or Data.speed_min or Data.Min or Data.min or 0,
				SpeedMax = Data.SpeedMax or Data.speed_max or Data.Max or Data.max or 10,
				StartMin = Data.StartMin or Data.start_min or 0,
				StartMax = Data.StartMax or Data.start_max or 100,
				EndMin = Data.EndMin or Data.end_min or 0,
				EndMax = Data.EndMax or Data.end_max or 100,

				SpeedDecimals = Data.SpeedDecimals or Data.speed_decimals or Data.Decimals or Data.decimals or 0.01,
				RangeDecimals = Data.RangeDecimals or Data.range_decimals or 1,
				SpeedSuffix = Data.SpeedSuffix or Data.speed_suffix or Data.Suffix or Data.suffix or "",
				StartSuffix = Data.StartSuffix or Data.start_suffix or Data.RangeSuffix or Data.range_suffix or "%",
				EndSuffix = Data.EndSuffix or Data.end_suffix or Data.RangeSuffix or Data.range_suffix or "%",

				Callback = Data.Callback or Data.callback or function() end,
				Disabled = false,
				Items = {},
			}

			local EntryItems = Entry.Items

			EntryItems["Block"] = Instances:Create("Frame", {
				Parent = Items["SubSliderRow"].Instance,
				Name = "\0",
				Size = SubSlider.Compact and UDim2New(0, 0, 0, 0) or UDim2New(0, 120, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = SubSlider.Compact and Enum.AutomaticSize.XY or Enum.AutomaticSize.Y,
				ZIndex = 2,
			})

			Instances:Create("UIListLayout", {
				Parent = EntryItems["Block"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 4),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
			})

			local SpeedTrackParent = EntryItems["Block"].Instance
			local SpeedTrackSize
			if SubSlider.Compact and Entry.HideRange then
				SpeedTrackSize = UDim2New(0, COMPACT_TRACK_WIDTH, 0, TRACK_HEIGHT)
			else
				SpeedTrackSize = UDim2New(1, 0, 0, TRACK_HEIGHT)
			end

			local SpeedTrack = CreateTrack(SpeedTrackParent, 0, 2, SpeedTrackSize)
			EntryItems["SpeedAccent"] = SpeedTrack["Accent"]
			EntryItems["SpeedLabel"] = SpeedTrack["Label"]
			EntryItems["SpeedButton"] = SpeedTrack["Track"]

			if not Entry.HideRange then
				EntryItems["RangeRow"] = Instances:Create("Frame", {
					Parent = EntryItems["Block"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 0, TRACK_HEIGHT),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 2,
					LayoutOrder = 1,
				})

				Instances:Create("UIListLayout", {
					Parent = EntryItems["RangeRow"].Instance,
					Name = "\0",
					Padding = UDimNew(0, RANGE_GAP),
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					VerticalFlex = Enum.UIFlexAlignment.Fill,
				})

				local StartTrack = CreateTrack(EntryItems["RangeRow"].Instance, 0, 2, UDim2New(1, 0, 1, 0))
				EntryItems["StartAccent"] = StartTrack["Accent"]
				EntryItems["StartLabel"] = StartTrack["Label"]
				EntryItems["StartButton"] = StartTrack["Track"]

				local EndTrack = CreateTrack(EntryItems["RangeRow"].Instance, 1, 2, UDim2New(1, 0, 1, 0))
				EntryItems["EndAccent"] = EndTrack["Accent"]
				EntryItems["EndLabel"] = EndTrack["Label"]
				EntryItems["EndButton"] = EndTrack["Track"]
			end

			function Entry:Set(Value, Silent)
				EntrySet(Entry, Value, Silent)
			end

			function Entry:Get()
				return Entry.Speed, Entry.Start, Entry["End"]
			end

			function Entry:SetDisabled(Bool)
				Entry.Disabled = Bool
				local Transparency = Bool and 0.6 or 0

				for _, Key in {"SpeedButton", "StartButton", "EndButton"} do
					if EntryItems[Key] then
						EntryItems[Key]:Tween(nil, {BackgroundTransparency = Transparency})
					end
				end

				for _, Key in {"SpeedAccent", "StartAccent", "EndAccent"} do
					if EntryItems[Key] then
						EntryItems[Key]:Tween(nil, {BackgroundTransparency = Transparency})
					end
				end

				for _, Key in {"SpeedLabel", "StartLabel", "EndLabel"} do
					if EntryItems[Key] then
						EntryItems[Key]:Tween(nil, {TextTransparency = Transparency})
					end
				end
			end

			local function BindTrack(TrackItem, Kind)
				TrackItem:Connect("InputBegan", function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						if Entry.Disabled or not Library:CheckLifetime(Entry) then
							return
						end

						SubSlider.SlidingEntry = Entry
						SubSlider.SlidingKind = Kind
						UpdateEntryFromInput(Entry, Kind)

						Entry.InputChangedConnection = Input.Changed:Connect(function()
							if Input.UserInputState == Enum.UserInputState.End then
								SubSlider.SlidingEntry = nil
								SubSlider.SlidingKind = nil

								if Entry.InputChangedConnection then
									Entry.InputChangedConnection:Disconnect()
									Entry.InputChangedConnection = nil
								end

								Library:SaveAutoloadIfEnabled()
							end
						end)
					end
				end)
			end

			BindTrack(EntryItems["SpeedButton"], "Speed")
			if not Entry.HideRange then
				BindTrack(EntryItems["StartButton"], "Start")
				BindTrack(EntryItems["EndButton"], "End")
			end

			Entry:Set({
				Speed = Entry.Speed,
				Start = Entry.Start,
				["End"] = Entry["End"],
			}, true)

			Library:BindElementFlag(Entry.Flag, function(Value)
				if Entry.Disabled then
					return
				end

				Entry:Set(Value, Library.LoadingConfig == true)
			end)

			if type(Entry.Flag) == "string" and Entry.Flag ~= "" and type(Entry.Callback) == "function" then
				Library:RegisterConfigFlagCallback(Entry.Flag, function()
					if Entry.Disabled == true then
						return
					end
					Library:SafeCall(Entry.Callback, {
						Speed = Entry.Speed,
						Start = Entry.Start,
						["End"] = Entry["End"],
					})
				end)
			end

			local PageSearchData = Library.SearchItems[SubSlider.Page]

			if PageSearchData then
				TableInsert(PageSearchData, {
					Element = EntryItems["Block"],
					Name = Entry.Name,
				})
			end

			TableInsert(SubSlider.Entries, Entry)

			return SubSlider, Entry
		end

		if Data.SpeedDefault or Data.speed_default or Data.DefaultSpeed or Data.Default or Data.default then
			SubSlider:Add(Data)
		end

		SubSlider.InputChangedConnection = Library:Connect(UserInputService.InputChanged, function(Input)
			if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end

			if SubSlider.SlidingEntry and SubSlider.SlidingKind then
				UpdateEntryFromInput(SubSlider.SlidingEntry, SubSlider.SlidingKind)
			end
		end)

		function SubSlider:SetVisibility(Bool)
			Items["SubSliderContainer"].Instance.Visible = Bool
		end

		function SubSlider:Destroy()
			if SubSlider.InputChangedConnection then
				SubSlider.InputChangedConnection:Disconnect()
				SubSlider.InputChangedConnection = nil
			end

			for _, Entry in SubSlider.Entries do
				if Library.SetFlags[Entry.Flag] then
					Library.SetFlags[Entry.Flag] = nil
				end

				if Entry.InputChangedConnection then
					Entry.InputChangedConnection:Disconnect()
					Entry.InputChangedConnection = nil
				end
			end

			if Items["SubSliderContainer"] and Items["SubSliderContainer"].Instance then
				Items["SubSliderContainer"].Instance:Destroy()
				Items["SubSliderContainer"].Instance = nil
			end

			return SubSlider
		end

		SubSlider.Items = Items
		return SubSlider
	end

	Library.Sections.Dropdown = function(self, Data)
		Data = Data or {}

		local Dropdown = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Data.Name or Data.name or "Dropdown",
			Description = Data.Description or Data.description or nil,
			DescriptionColor = Data.DescriptionColor or Data.description_color or nil,
			Flag = Library:ResolveElementFlag(Data),
			Items = Data.Items or Data.items or { "One", "Two", "Three" },
			Tooltip = Data.Tooltip or Data.tooltip or nil,
			Default = Data.Default or Data.default or nil,
			Callback = Data.Callback or Data.callback or function() end,
			Multi = Data.Multi or Data.multi or false,
			Lifetime = Data.Lifetime or Data.lifetime or false,

			Value = (Data.Multi or Data.multi) and {} or nil,
			Options = {},
			IsOpen = false,
			Disabled = false,
		}

		if not Dropdown.Multi and type(Dropdown.Default) == "table" then
			Dropdown.Default = Dropdown.Default[1]
		end

		local Items = {}

		local HEADER_HEIGHT = 40
		local FOOTER_HEIGHT = 8
		local OPTION_HEIGHT = 25
		local OPTION_PADDING = 5
		local HOLDER_PADDING = 13
		local DROPDOWN_HEIGHT_CAP = 240

		Items["DropdownContainer"] = Instances:Create("Frame", {
			Parent = Dropdown.Section.Items["Content"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		})

		Instances:Create("UIListLayout", {
			Parent = Items["DropdownContainer"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top
		})

		Items["Text"] = Instances:Create("TextLabel", {
			Parent = Items["DropdownContainer"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 15),
			Position = UDim2New(0, 0, 0, 0),
			AnchorPoint = Vector2New(0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = Dropdown.Name,
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 4,
			LayoutOrder = 0
		}):AddToTheme({TextColor3 = 'Text'})

		Items["Text"]:Tooltip(Dropdown.Tooltip)

		if Dropdown.Description ~= nil and Dropdown.Description ~= "" then
			Items["Description"] = Instances:Create("TextLabel", {
				Parent = Items["DropdownContainer"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 15),
				Position = UDim2New(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Dropdown.Description,
				TextColor3 = Dropdown.DescriptionColor or Library.Theme["Text"],
				TextSize = 12,
				FontFace = Library.Font,
				TextTransparency = 0.5,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 4,
				LayoutOrder = 1
			})

			Library:BindDescriptionColor(Items["Description"], Dropdown.DescriptionColor)
		end

		Items["RealDropdown"] = Instances:Create("TextButton", {
			Parent = Items["DropdownContainer"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 25),
			Position = UDim2New(0, 0, 0, 0),
			AnchorPoint = Vector2New(0, 0),
			BackgroundColor3 = Library.Theme["Element"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			Active = false,
			Selectable = false,
			ZIndex = 2,
			LayoutOrder = 2
		}):AddToTheme({BackgroundColor3 = 'Element'})

		Instances:Create("UICorner", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIGradient", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			Rotation = 90,
			Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
		})

		Items["Value"] = Instances:Create("TextLabel", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			Size = UDim2New(1, -25, 0, 15),
			Position = UDim2New(0, 8, 0.5, 0),
			AnchorPoint = Vector2New(0, 0.5),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "...",
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 2,
			TextTruncate = Enum.TextTruncate.None
		}):AddToTheme({TextColor3 = 'Text'})

		Instances:Create("UIGradient", {
			Parent = Items["Value"].Instance,
			Name = "\0",
			Transparency = NumSequence{NumSequenceKeypoint(0, 0), NumSequenceKeypoint(0.676, 0), NumSequenceKeypoint(1, 1)}
		})

		Items["Icon"] = Instances:Create("ImageLabel", {
			Parent = Items["RealDropdown"].Instance,
			Name = "\0",
			Size = UDim2New(0, 23, 0, 23),
			Position = UDim2New(1, -13, 0.5, 0),
			AnchorPoint = Vector2New(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = "rbxassetid://126603363478667",
			ImageColor3 = Library.Theme["Text"],
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 2
		})

		Items["OptionHolder"] = Instances:Create("TextButton", {
			Parent = Library.UnusedHolder.Instance,
			Name = "\0",
			Size = UDim2New(0, 155, 0, HEADER_HEIGHT + OPTION_HEIGHT + HOLDER_PADDING + FOOTER_HEIGHT),
			Position = UDim2New(0, 0, 0, 5),
			AnchorPoint = Vector2New(0, 0),
			BackgroundColor3 = Library.Theme["Background"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			ClipsDescendants = true,
			AutoButtonColor = false,
			ZIndex = 5,
			Visible = false,
			SelectionGroup = true
		}):AddToTheme({BackgroundColor3 = 'Background'})

		Instances:Create("UICorner", {
			Parent = Items["OptionHolder"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Items["Holder"] = Instances:Create("ScrollingFrame", {
			Parent = Items["OptionHolder"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 0, OPTION_HEIGHT + HOLDER_PADDING),
			Position = UDim2New(0, 8, 0, 40),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Active = true,
			ZIndex = 5,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			BottomImage = "rbxassetid://128693616966482",
			CanvasSize = UDim2New(0, 0, 0, 0),
			MidImage = "rbxassetid://128693616966482",
			ScrollBarImageColor3 = Library.Theme["Accent"],
			ScrollBarThickness = 3,
			TopImage = "rbxassetid://128693616966482"
		}):AddToTheme({ScrollBarImageColor3 = 'Accent'})

		Instances:Create("UIPadding", {
			Parent = Items["Holder"].Instance,
			Name = "\0",
			PaddingLeft = UDimNew(0, 5),
			PaddingRight = UDimNew(0, 8),
			PaddingTop = UDimNew(0, 5),
			PaddingBottom = UDimNew(0, 8)
		})

		Instances:Create("UIListLayout", {
			Parent = Items["Holder"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder
		})

		Items["Search"] = Instances:Create("Frame", {
			Parent = Items["OptionHolder"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 0, 30),
			Position = UDim2New(0, 8, 0, 8),
			BackgroundColor3 = Library.Theme["Inline"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ZIndex = 5
		}):AddToTheme({BackgroundColor3 = 'Inline'})

		Instances:Create("UICorner", {
			Parent = Items["Search"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Items["SearchIcon"] = Instances:Create("ImageLabel", {
			Parent = Items["Search"].Instance,
			Name = "\0",
			Size = UDim2New(0, 20, 0, 20),
			Position = UDim2New(0, 8, 0.5, 0),
			AnchorPoint = Vector2New(0, 0.5),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://71924825350727",
			ImageTransparency = 0.4000000059604645,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 5
		})

		Items["Input"] = Instances:Create("TextBox", {
			Parent = Items["Search"].Instance,
			Name = "\0",
			Size = UDim2New(1, -43, 0, 15),
			Position = UDim2New(0, 35, 0.5, 0),
			AnchorPoint = Vector2New(0, 0.5),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Left,
			PlaceholderText = "Search..",
			PlaceholderColor3 = Library.Theme["Inactive Text"],
			ZIndex = 5
		}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

		function Dropdown:Get()
			return Dropdown.Value
		end

		function Dropdown:SetVisibility(Bool)
			Items["DropdownContainer"].Instance.Visible = Bool
		end

		function Dropdown:SetDisabled(Bool)
			Dropdown.Disabled = Bool

			if Dropdown.Disabled then
				if Items["Text"] then
					Items["Text"]:Tween(nil, {TextTransparency = 0.6})
				end
				Items["RealDropdown"]:Tween(nil, {BackgroundTransparency = 0.6})
				Items["Value"]:Tween(nil, {TextTransparency = 0.6})
				Items["Icon"]:Tween(nil, {ImageTransparency = 0.6})

				Dropdown:SetOpen(false)
			else
				if Items["Text"] then
					Items["Text"]:Tween(nil, {TextTransparency = 0})
				end
				Items["RealDropdown"]:Tween(nil, {BackgroundTransparency = 0})
				Items["Value"]:Tween(nil, {TextTransparency = 0})
				Items["Icon"]:Tween(nil, {ImageTransparency = 0})
			end
		end

		local Debounce = false
		local RenderStepped

		local function CountVisibleOptions()
			local Count = 0

			for _, Child in Items["Holder"].Instance:GetChildren() do
				if Child:IsA("TextButton") and Child.Visible then
					Count += 1
				end
			end

			return Count
		end

		local function GetListContentHeight()
			local ListLayout = Items["Holder"].Instance:FindFirstChildOfClass("UIListLayout")
			local HolderPadding = Items["Holder"].Instance:FindFirstChildOfClass("UIPadding")
			local ContentHeight = 0

			if ListLayout and ListLayout.AbsoluteContentSize.Y > 0 then
				ContentHeight = ListLayout.AbsoluteContentSize.Y
			else
				local Count = CountVisibleOptions()

				if Count <= 0 then
					ContentHeight = OPTION_HEIGHT
				else
					ContentHeight = Count * OPTION_HEIGHT + math.max(0, Count - 1) * OPTION_PADDING
				end
			end

			if HolderPadding then
				ContentHeight += HolderPadding.PaddingTop.Offset + HolderPadding.PaddingBottom.Offset
			else
				ContentHeight += HOLDER_PADDING
			end

			return math.max(OPTION_HEIGHT + HOLDER_PADDING, ContentHeight)
		end

		local function UpdateListLayout()
			local ListHeight = GetListContentHeight()
			local MaxListHeight = math.max(OPTION_HEIGHT + HOLDER_PADDING, DROPDOWN_HEIGHT_CAP - HEADER_HEIGHT - FOOTER_HEIGHT)
			local ClampedListHeight = math.min(ListHeight, MaxListHeight)
			local NeedsScroll = ListHeight > ClampedListHeight + 0.5

			Items["Holder"].Instance.Size = UDim2New(1, -16, 0, ClampedListHeight)
			Items["Holder"].Instance.ScrollingEnabled = NeedsScroll
			Items["Holder"].Instance.ScrollBarImageTransparency = NeedsScroll and 0 or 1

			return HEADER_HEIGHT + ClampedListHeight + FOOTER_HEIGHT
		end

		local function UpdatePosition()
			if not Library or not Items["OptionHolder"].Instance.Parent then return end

			local Scale = Library.UIScaleNum or (Library.Holder.Instance:FindFirstChildOfClass("UIScale") or {Scale = 1}).Scale
			local Button = Items["RealDropdown"].Instance
			local MainFrame = Dropdown.Window.Items["MainFrame"].Instance
			local MainFrameRight = MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X - 8
			local MainFrameBottom = MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y - 8
			local MainFrameTop = MainFrame.AbsolutePosition.Y + 8

			local ContentHeight = UpdateListLayout()
			local Left = math.max(Button.AbsolutePosition.X, MainFrame.AbsolutePosition.X + 8)
			local Out = math.min(Button.AbsolutePosition.X + Button.AbsoluteSize.X, MainFrameRight) - Left
			local Gap = 5
			local OpenY = Button.AbsolutePosition.Y + Button.AbsoluteSize.Y + Gap
			local Below = MainFrameBottom - OpenY
			local Above = Button.AbsolutePosition.Y - Gap - MainFrameTop
			local DropdownSize = math.min(ContentHeight, DROPDOWN_HEIGHT_CAP, math.max(Below, Above))

			if Below >= DropdownSize then
				Items["OptionHolder"].Instance.Position = UDim2New(0, Left / Scale, 0, OpenY / Scale)
				Items["OptionHolder"].Instance.Size = UDim2New(0, Out / Scale, 0, math.min(DropdownSize, Below) / Scale)
			else
				local CloseY = Button.AbsolutePosition.Y - Gap
				local Top = math.max(CloseY - DropdownSize, MainFrameTop)

				Items["OptionHolder"].Instance.Position = UDim2New(0, Left / Scale, 0, Top / Scale)
				Items["OptionHolder"].Instance.Size = UDim2New(0, Out / Scale, 0, (CloseY - Top) / Scale)
			end
		end

		local function ScheduleLayoutUpdate()
			task.defer(function()
				if not Library or not Items["Holder"] or not Items["Holder"].Instance then
					return
				end

				if Dropdown.IsOpen then
					UpdatePosition()
				else
					UpdateListLayout()
				end
			end)
		end

		function Dropdown:SetOpen(Bool)
			if Debounce then
				return
			end

			if not Library:CheckLifetime(Dropdown) then
				return
			end

			Dropdown.IsOpen = Bool
			Debounce = true

			local Theme = Library.Theme
			local OpenTweenInfo = TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

			if Dropdown.IsOpen then
				wait()

				if Items["Icon"] and Items["Icon"].Instance then
					Items["Icon"]:Tween(OpenTweenInfo, {
						Rotation = 90,
						ImageColor3 = Theme["Accent"],
					})
				end
			elseif Items["Icon"] and Items["Icon"].Instance then
				Items["Icon"]:Tween(OpenTweenInfo, {
					Rotation = 0,
					ImageColor3 = Theme["Text"],
				})
			end

			if Dropdown.IsOpen then
				Items["OptionHolder"].Instance.Visible = true
				Items["OptionHolder"].Instance.Parent = Library.Holder.Instance

				UpdatePosition()
				ScheduleLayoutUpdate()

				RenderStepped = RunService.RenderStepped:Connect(function()
					if not Library then return end
					UpdatePosition()
				end)

				for Index, Value in Library.OpenFrames do
					if Value ~= Dropdown and type(Value.SetOpen) == "function" then
						Value:SetOpen(false)
					end
				end

				Library:HideOnOverlap(true, Items["OptionHolder"].Instance)
				Library.OpenFrames[Dropdown] = Dropdown
			else
				if Library.OpenFrames[Dropdown] then
					Library.OpenFrames[Dropdown] = nil
				end

				if RenderStepped then
					RenderStepped:Disconnect()
					RenderStepped = nil
				end

				Library:HideOnOverlap(false, Items["OptionHolder"].Instance)
			end

			local Descendants = Items["OptionHolder"].Instance:GetDescendants()
			TableInsert(Descendants, Items["OptionHolder"].Instance)

			local NewTween

			for Index, Value in Descendants do
				local TransparencyProperty = Tween:GetProperty(Value)

				if not TransparencyProperty then
					continue
				end

				if not Value.ClassName:find("UI") then
					Value.ZIndex = Dropdown.IsOpen and 127 or 1
				end

				if type(TransparencyProperty) == "table" then
					for _, Property in TransparencyProperty do
						NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
					end
				else
					NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
				end
			end

			if not NewTween or not NewTween.Tween then
				Debounce = false

				Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
				wait(0.2)
				Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
				return
			end

			NewTween.Tween.Completed:Connect(function()
				Debounce = false

				Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
				wait(0.2)
				Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
			end)
		end

		function Dropdown:Set(Option, Silent)
			if Option == nil then
				return
			end

			local Flags = Library.Flags
			local Flag = Dropdown.Flag

			if Dropdown.Multi then
				if type(Option) ~= "table" then
					return
				end

				Dropdown.Value = Option
				Flags[Flag] = Option

				for _, Value in Option do
					local OptionData = Dropdown.Options[Value]

					if OptionData then
						OptionData.Selected = true
						OptionData:Toggle("Active")
					end
				end

				Library.Localization:SetDropdownDisplay(Dropdown, Items["Value"].Instance)
			else
				local String = Option

				if type(String) == "table" then
					String = String[1]
				end

				if type(String) ~= "string" and type(String) ~= "number" then
					return
				end

				String = tostring(String)
				if String == "" or String == "nil" then
					return
				end

				local OptionData = Dropdown.Options[String]
				if not OptionData then
					return
				end

				Dropdown.Value = String
				Flags[Flag] = String

				for _, Value in Dropdown.Options do
					Value:Toggle(Value == OptionData and "Active" or "Inactive")
				end

				Library.Localization:ApplyText(Items["Value"].Instance, String, "Text")
			end

			if Dropdown.Callback and Library:ShouldFireElementCallback(Silent) then
				Library:SafeCall(Dropdown.Callback, Dropdown.Value)
			end

			if Library:ShouldSaveAutoload(Silent) then
				Library:SaveAutoloadIfEnabled()
			end
		end

		function Dropdown:Add(Option)
			local OptionButton = Instances:Create("TextButton", {
				Parent = Items["Holder"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 25),
				BackgroundColor3 = Library.Theme["Inline"],
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = "",
				TextColor3 = FromRGB(0, 0, 0),
				TextSize = 14,
				FontFace = Library.Font,
				AutoButtonColor = false,
				ZIndex = 5
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = OptionButton.Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			local OptionText = Instances:Create("TextLabel", {
				Parent = OptionButton.Instance,
				Name = "\0",
				Size = UDim2New(1, -15, 1, 0),
				Position = UDim2New(0, 4, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Option,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextTransparency = 0.4000000059604645,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 5
			}):AddToTheme({TextColor3 = 'Text'})

			local OptionData = {
				Button = OptionButton,
				Name = Option,
				Text = OptionText,
				Selected = false
			}

			function OptionData:Toggle(Value)
				if Value == "Active" then
					OptionData.Text:Tween(nil, {TextTransparency = 0, Position = UDim2New(0, 8, 0, 0)})
					OptionData.Button:Tween(nil, {BackgroundTransparency = 0})
				else
					OptionData.Text:Tween(nil, {TextTransparency = 0.4, Position = UDim2New(0, 4, 0, 0)})
					OptionData.Button:Tween(nil, {BackgroundTransparency = 1})
				end
			end

			function OptionData:Set()
				if not Library:CheckLifetime(Dropdown) then
					return
				end

				OptionData.Selected = not OptionData.Selected

				local Flags = Library.Flags
				local Flag = Dropdown.Flag

				if Dropdown.Multi then
					local Index = TableFind(Dropdown.Value, OptionData.Name)

					if Index then
						TableRemove(Dropdown.Value, Index)
					else
						TableInsert(Dropdown.Value, OptionData.Name)
					end

					OptionData:Toggle(Index and "Inactive" or "Active")
					Flags[Flag] = Dropdown.Value

					Library.Localization:SetDropdownDisplay(Dropdown, Items["Value"].Instance)
				else
					if OptionData.Selected then
						Dropdown.Value = OptionData.Name
						Flags[Flag] = OptionData.Name

						for _, Value in Dropdown.Options do
							if Value ~= OptionData then
								Value.Selected = false
								Value:Toggle("Inactive")
							end
						end

						OptionData:Toggle("Active")
						Library.Localization:ApplyText(Items["Value"].Instance, OptionData.Name, "Text")
					else
						Dropdown.Value = nil
						Flags[Flag] = nil

						OptionData:Toggle("Inactive")
						Library.Localization:ApplyText(Items["Value"].Instance, "...", "Text")
					end
				end

				if Dropdown.Callback then
					Library:SafeCall(Dropdown.Callback, Dropdown.Value)
				end

				Library:SaveAutoloadIfEnabled()
			end

			OptionData.Button:Connect("MouseButton1Down", function(Input)
				if Dropdown.Disabled then
					return
				end
				OptionData:Set()
			end)

			Dropdown.Options[OptionData.Name] = OptionData
			ScheduleLayoutUpdate()

			return OptionData
		end

		function Dropdown:Remove(Option)
			if Dropdown.Options[Option] then
				Dropdown.Options[Option].Button:Clean()
				Dropdown.Options[Option] = nil
				ScheduleLayoutUpdate()
			end
		end

		function Dropdown:Refresh(List)
			for _, OptionData in Dropdown.Options do
				OptionData.Button:Clean()
			end

			Dropdown.Options = {}

			for _, Value in List do
				Dropdown:Add(Value)
			end
		end

		local PageSearchData = Library.SearchItems[Dropdown.Page]

		if PageSearchData then
			local SearchData = {
				Element = Items["DropdownContainer"],
				Name = Dropdown.Name,
			}

			TableInsert(PageSearchData, SearchData)
		end

		if IsMobile then
			Items["RealDropdown"]:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.Touch then
					if Dropdown.Disabled then
						return
					end

					Dropdown:SetOpen(not Dropdown.IsOpen)
				end
			end)
		else
			Items["RealDropdown"]:Connect("MouseButton1Down", function()
				if Dropdown.Disabled then
					return
				end

				Dropdown:SetOpen(not Dropdown.IsOpen)
			end)
		end

		Library:Connect(UserInputService.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Dropdown.Disabled then
					return
				end

				if Dropdown.IsOpen then
					if Library:IsMouseOverFrame(Items["OptionHolder"]) then
						return
					end

					Dropdown:SetOpen(false)
				end
			end
		end)

		Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
			local SearchText = Items["Input"].Instance.Text

			for Index, Value in Dropdown.Options do
				if StringFind(StringLower(Value.Name), StringLower(SearchText)) then
					Value.Button.Instance.Visible = true
				else
					Value.Button.Instance.Visible = false
				end
			end

			ScheduleLayoutUpdate()
		end)

		Items["RealDropdown"]:Connect("Changed", function(Property)
			if Property == "AbsolutePosition" and Dropdown.IsOpen then
				Dropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
				Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
			end
		end)

		for Index, Value in Dropdown.Items do
			Dropdown:Add(Value)
		end

		UpdateListLayout()

		if Dropdown.Default ~= nil then
			Dropdown:Set(Dropdown.Default, true)
		else
			Library.Localization:SetDropdownDisplay(Dropdown, Items["Value"].Instance)
		end

		if Items["Icon"] and Items["Icon"].Instance then
			pcall(function()
				Items["Icon"].Instance.Rotation = 0
			end)
		end

		Library:BindElementFlag(Dropdown.Flag, function(Value)
			if Dropdown.Disabled then
				return
			end

			Dropdown:Set(Value, Library.LoadingConfig == true)
		end, Dropdown)

		function Dropdown:Destroy()
			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			return Dropdown
		end

		Dropdown.Items = Items
		Library.Localization:RegisterDropdown(Dropdown, Items["Value"].Instance)
		return Dropdown
	end

	Library.Sections.Label = function(self, Name, Description, Tooltip, DescriptionColor)
		if type(Name) == "table" then
			local Data = Name
			DescriptionColor = Data.DescriptionColor or Data.description_color
			Tooltip = Data.Tooltip or Data.tooltip
			Description = Data.Description or Data.description
			Name = Data.Name or Data.name
		end

		local Label = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Name or "Label",
			Description = Description or nil,
			DescriptionColor = DescriptionColor,
			HasSubElements = false,
		}

		local Items = {} do
			Items["Label"] = Instances:Create("Frame", {
				Parent = Label.Section.Items["Content"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2
			})

			Items["Label"]:Tooltip(Tooltip)

			Instances:Create("UIListLayout", {
				Parent = Items["Label"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 0),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})

			Items["MainRow"] = Instances:Create("Frame", {
				Parent = Items["Label"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2,
				LayoutOrder = 0
			})

			Instances:Create("UIListLayout", {
				Parent = Items["MainRow"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center
			})

			Items["TextContainer"] = Instances:Create("Frame", {
				Parent = Items["MainRow"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2,
				LayoutOrder = 0
			})

			Instances:Create("UIFlexItem", {
				Parent = Items["TextContainer"].Instance,
				Name = "\0",
				FlexMode = Enum.UIFlexMode.Fill,
			})

			Instances:Create("UIListLayout", {
				Parent = Items["TextContainer"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 0),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top
			})

			Items["Text"] = Instances:Create("TextLabel", {
				Parent = Items["TextContainer"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				Position = UDim2New(0, 0, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Label.Name,
				TextColor3 = Library.Theme["Text"],
				TextSize = 14,
				FontFace = Library.Font,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 2,
				LayoutOrder = 0
			}):AddToTheme({TextColor3 = 'Text'})

			if Label.Description ~= nil and Label.Description ~= "" then
				Items["Description"] = Instances:Create("TextLabel", {
					Parent = Items["TextContainer"].Instance,
					Name = "\0",
					Size = UDim2New(1, 0, 0, 0),
					Position = UDim2New(0, 0, 0, 0),
					AnchorPoint = Vector2New(0, 0),
					BackgroundTransparency = 1,
					BorderColor3 = FromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Text = Label.Description,
					TextColor3 = Label.DescriptionColor or Library.Theme["Text"],
					TextSize = 12,
					FontFace = Library.Font,
					TextTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextWrapped = true,
					AutomaticSize = Enum.AutomaticSize.Y,
					ZIndex = 2,
					LayoutOrder = 1
				})

				Library:BindDescriptionColor(Items["Description"], Label.DescriptionColor)
			end

			Items["SubElements"] = Instances:Create("Frame", {
				Parent = Items["MainRow"].Instance,
				Name = "\0",
				Size = UDim2New(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				LayoutOrder = 1
			})

			Instances:Create("UIListLayout", {
				Parent = Items["SubElements"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Center
			})
		end

		function Label:Colorpicker(Data)
			Data = Data or {}

			Label.HasSubElements = true

			local NewColorpicker = Library:CreateColorpicker({
				Parent = Items["SubElements"],
				Page = Label.Page,
				Section = Label.Section,
				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
				Callback = Data.Callback or Data.callback or function() end,
				Alpha = Data.Alpha or Data.alpha or false
			})

			return NewColorpicker
		end

		function Label:Keybind(Data)
			Data = Data or {}

			Label.HasSubElements = true

			local NewKeybind = Library:CreateKeybind({
				Parent = Items["SubElements"],
				Name = Data.Name or Data.name or Label.Name,
				Page = Label.Page,
				Section = Label.Section,
				Flag = Library:ResolveElementFlag(Data),
				Default = Data.Default or Data.default or KEYBIND_NONE_KEY,
				Mode = Data.Mode or Data.mode or "Toggle",
				Callback = Data.Callback or Data.callback or function() end
			})

			return NewKeybind
		end

		function Label:SetText(Text)
			if Items["Text"] and Items["Text"].Instance then
				Items["Text"].Instance.Text = tostring(Text)
			end
		end

		function Label:SetTextColor(Color)
			if not Items["Text"] or not Items["Text"].Instance then
				return
			end

			if type(Color) == "table" then
				Color = FromRGB(Color[1], Color[2], Color[3])
			elseif type(Color) == "string" then
				Color = FromHex(Color)
			end

			Items["Text"].Instance.TextColor3 = Color
		end

		function Label:SetVisibility(Bool)
			if Items["Label"] and Items["Label"].Instance then
				Items["Label"].Instance.Visible = Bool
			end
		end

		function Label:Destroy()
			for _, Item in Items do
				if Item and Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			return Label
		end

		Label.Items = Items
		return Label
	end
	Library.Sections.Textbox = function(self, Data)
		Data = Data or {}

		local Textbox = {
			Window = self.Window,
			Page = self.Page,
			Section = self,

			Name = Data.Name or Data.name or "Textbox",
			Description = Data.Description or Data.description or nil,
			DescriptionColor = Data.DescriptionColor or Data.description_color or nil,
			Flag = Library:ResolveElementFlag(Data),
			Default = Data.Default or Data.default or "",
			Tooltip = Data.Tooltip or Data.tooltip or nil,
			Callback = Data.Callback or Data.callback or function() end,
			Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",
			Numeric = Data.Numeric or Data.numeric or false,
			Finished = Data.Finished or Data.finished or false,
			Lifetime = Data.Lifetime or Data.lifetime or false,

			Disabled = false,

			Value = ""
		}

		local Items = {}

		Items["TextboxContainer"] = Instances:Create("Frame", {
			Parent = Textbox.Section.Items["Content"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 2
		})

		Instances:Create("UIListLayout", {
			Parent = Items["TextboxContainer"].Instance,
			Name = "\0",
			Padding = UDimNew(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top
		})

		Items["Text"] = Instances:Create("TextLabel", {
			Parent = Items["TextboxContainer"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 0),
			Position = UDim2New(0, 0, 0, 0),
			AnchorPoint = Vector2New(0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = Textbox.Name,
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 4,
			LayoutOrder = 0
		}):AddToTheme({TextColor3 = 'Text'})

		Items["Text"]:Tooltip(Textbox.Tooltip)

		if Textbox.Description ~= nil and Textbox.Description ~= "" then
			Items["Description"] = Instances:Create("TextLabel", {
				Parent = Items["TextboxContainer"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 0),
				Position = UDim2New(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Text = Textbox.Description,
				TextColor3 = Textbox.DescriptionColor or Library.Theme["Text"],
				TextSize = 12,
				FontFace = Library.Font,
				TextTransparency = 0.5,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				ZIndex = 4,
				LayoutOrder = 1
			})

			Library:BindDescriptionColor(Items["Description"], Textbox.DescriptionColor)
		end

		Items["Background"] = Instances:Create("Frame", {
			Parent = Items["TextboxContainer"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 0, 25),
			Position = UDim2New(0, 0, 0, 0),
			AnchorPoint = Vector2New(0, 0),
			BackgroundColor3 = Library.Theme["Element"],
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ClipsDescendants = false,
			ZIndex = 2,
			LayoutOrder = 2
		}):AddToTheme({BackgroundColor3 = 'Element'})

		Instances:Create("UIGradient", {
			Parent = Items["Background"].Instance,
			Name = "\0",
			Rotation = 90,
			Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(216, 216, 216))}
		})

		Instances:Create("UICorner", {
			Parent = Items["Background"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Items["Input"] = Instances:Create("TextBox", {
			Parent = Items["Background"].Instance,
			Name = "\0",
			Size = UDim2New(1, -16, 1, 0),
			Position = UDim2New(0, 8, 0, 0),
			BackgroundTransparency = 1,
			BorderColor3 = FromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			TextColor3 = Library.Theme["Text"],
			TextSize = 14,
			FontFace = Library.Font,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextStrokeColor3 = Library.Theme["Text"],
			PlaceholderText = Textbox.Placeholder,
			PlaceholderColor3 = Library.Theme["Inactive Text"],
			ClearTextOnFocus = false,
			CursorPosition = -1,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextWrapped = false,
			ZIndex = 2
		}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

		Library.TextboxElements[Textbox] = {
			Textbox = Items["TextboxContainer"],
			Background = Items["Background"],
			Input = Items["Input"]
		}

		local InputInstance = Items["Input"].Instance

		function Textbox:Get()
			return Textbox.Value
		end

		function Textbox:SetDisabled(Bool)
			Textbox.Disabled = Bool

			if Textbox.Disabled then
				if Items["Text"] then
					Items["Text"]:Tween(nil, {TextTransparency = 0.6})
				end
				Items["Background"]:Tween(nil, {BackgroundTransparency = 0.6})
				Items["Input"]:Tween(nil, {TextTransparency = 0.6})
				InputInstance.Interactable = false
			else
				if Items["Text"] then
					Items["Text"]:Tween(nil, {TextTransparency = 0})
				end
				Items["Background"]:Tween(nil, {BackgroundTransparency = 0})
				Items["Input"]:Tween(nil, {TextTransparency = 0})
				InputInstance.Interactable = true
			end
		end

		function Textbox:SetVisibility(Bool)
			Items["TextboxContainer"].Instance.Visible = Bool
		end

		function Textbox:Set(Value, Silent)
			if Textbox.Disabled then
				return
			end

			if not Library:CheckLifetime(Textbox, "Textbox") then
				return
			end

			local String = tostring(Value)

			if Textbox.Numeric then
				if (not tonumber(String)) and StringLen(String) > 0 then
					return
				end
			end

			Textbox.Value = Value

			if InputInstance.Text ~= String then
				InputInstance.Text = String
			end

			if Textbox.Flag then
				Library.Flags[Textbox.Flag] = Value
			end

			if Textbox.Callback and Library:ShouldFireElementCallback(Silent) then
				Library:SafeCall(Textbox.Callback, Value)
			end

			if Library:ShouldSaveAutoload(Silent) then
				Library:SaveAutoloadIfEnabled()
			end
		end

		local PageSearchData = Library.SearchItems[Textbox.Page]

		if PageSearchData then
			local SearchData = {
				Element = Items["TextboxContainer"],
				Name = Textbox.Name,
			}

			TableInsert(PageSearchData, SearchData)
		end

		if Textbox.Finished then
			Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
				if Textbox.Disabled then
					return
				end

				if not Library:CheckLifetime(Textbox) then
					return
				end

				if PressedEnterQuestionMark then
					Textbox:Set(InputInstance.Text)
				end
			end)
		else
			Library:Connect(InputInstance:GetPropertyChangedSignal("Text"), function()
				if Textbox.Disabled then
					return
				end

				if not Library:CheckLifetime(Textbox) then
					return
				end

				Textbox:Set(InputInstance.Text)
			end)
		end

		if Textbox.Default then
			Textbox:Set(Textbox.Default, true)
		end

		Library:BindElementFlag(Textbox.Flag, function(Value)
			if Textbox.Disabled then
				return
			end

			Textbox:Set(Value, Library.LoadingConfig == true)
		end, Textbox)

		function Textbox:Destroy()
			for _, Item in Items do
				if Item.Instance then
					Item.Instance:Destroy()
					Item.Instance = nil
				end
			end

			return Textbox
		end

		Textbox.Items = Items
		return Textbox
	end

	Library.CreateFontSettingsSection = function(self, Page, Data)
		Data = Data or {}

		local Section = Page:Section({
			Name = Data.Name or Data.name or "Font Setting",
			Side = Data.Side or Data.side or 2,
		})

		Section:Dropdown({
			Name = "Font",
			Flag = "UI Font",
			Description = "List of fonts to use on the Solix Hub UI",
			Items = self:GetFontNames(),
			Default = self.FontSettings.Name,
			Multi = false,
			Callback = function(Value)
				task.defer(function()
					if not self:SetFont(Value) then
						self:Notification({
							Name = "Font Error",
							Description = "Failed to load font: " .. tostring(Value),
							Color = Color3.fromRGB(255, 80, 80),
							Duration = 4,
						})
					end
				end)
			end,
		})

		defer(function()
			self:ApplyFontSettings()
		end)

		return Section
	end

	Library.CreateSettingsPage = function(self, Window, Watermark, KeybindList)
		Library:LoadLocalSettings()

		local Settings = Window:Page({Name = "Settings", Columns = 2})

		local AccountTab = Settings:SubPage({Name = "Account"})
		local ThemesTab = Settings:SubPage({Name = "Themes"})
		local MenuTab = Settings:SubPage({Name = "Menu"})
		local ConfigsTab = Settings:SubPage({Name = "Configurations"})

		local ScaleValues = {
			["Very Small"] = 1200,
			["Small"] = 1100,
			["Medium"] = 1000,
			["Large"] = 800,
			["Bigger"] = 600,
			["Massive"] = 500,
		}

		if ScaleValues[Library.MenuScalePreset] then
			Library:SetScaleNumeric(ScaleValues[Library.MenuScalePreset])
		end

		do 
			local PlayerInfo_Section = AccountTab:Section({Name = "Player Info", Side = 1})

			Library:GetDataFromPlayer(PlayerInfo_Section)
		end

		do
			local ThemeSetting_Section = ThemesTab:Section({Name = "Theme Setting", Side = 1})
			local ThemeConfig_Section = ThemesTab:Section({Name = "Theme Config", Side = 2})
			local Theme_Colorpicker = {}

			local ThemeFolder = Library:GetFolderTheme()

			local function NotifySuccessTheme(Message)
				Library:Notification({
					Name = "Success",
					Description = Message,
					Color = Color3.fromRGB(0, 255, 0),
					Duration = 5
				})
			end

			local function NotifyErrorTheme(Message)
				Library:Notification({
					Name = "Error",
					Description = Message,
					Color = Color3.fromRGB(255, 0, 0),
					Duration = 5
				})
			end

			do
				for Index, Value in Library.Theme do
					Theme_Colorpicker[Index] = ThemeSetting_Section:Label(Index, Index:lower() .. " theme color"):Colorpicker({
						Flag = Index,
						Default = Value,
						Alpha = 0,
						Callback = function(Value)
							Library.Theme[Index] = Value
							Library:ChangeTheme(Index, Value)
						end
					})
				end
			end

			do
				local Theme_Name
				local Theme_Selected

				local Theme_Dropdown = ThemeConfig_Section:Dropdown({
					Name = "Themes Select",
					Flag = "Themes Select",
					Description = "Select a theme preset",
					Items = {},
					Multi = false,
					Callback = function(Value)
						Theme_Selected = Value

						if Library.AutoloadThemeEnabled and Theme_Selected and Theme_Selected ~= "" then
							pcall(function()
								writefile(GetAutoloadThemeNamePath(), Theme_Selected)
							end)
						end
					end,
				})

				ThemeConfig_Section:Toggle({
					Name = "Autoload Theme",
					Flag = "Autoload Theme On Execute",
					Description = "Autoloads the selected theme on next load",
					Default = Library.AutoloadThemeEnabled == true,
					Callback = function(Value)
						Library.AutoloadThemeEnabled = Value
						Library:SaveLocalSettings()

						if Value and Theme_Selected and Theme_Selected ~= "" then
							pcall(function()
								writefile(GetAutoloadThemeNamePath(), Theme_Selected)
							end)
						elseif not Value then
							pcall(function()
								if isfile(GetAutoloadThemeNamePath()) then
									delfile(GetAutoloadThemeNamePath())
								end
							end)
						end
					end,
				})

				ThemeConfig_Section:Textbox({
					Name = "Theme Name",
					Flag = "Theme Name",
					Description = "Enter a name for your theme",
					Placeholder = "Theme name...",
					Finished = true,
					Callback = function(Value)
						Theme_Name = Value
					end,
				})

				ThemeConfig_Section:Button():Add("Create", function()
					if not Theme_Name or Theme_Name == "" then
						return
					end

					local Success, Error = pcall(function()
						writefile(ThemeFolder .. Theme_Name .. ".json", Library:GetTheme())
					end)

					if Success then
						Library:RefreshThemeList(Theme_Dropdown)
						NotifySuccessTheme("Succesfully created theme: " .. Theme_Name)
					else
						NotifyErrorTheme("Failed to create theme: " .. Theme_Name .. " " .. tostring(Error))
					end
				end):Add("Delete", function()
					if not Theme_Selected then
						NotifyErrorTheme("Please select a theme first")
						return
					end

					local ThemePath = ThemeFolder .. Theme_Selected .. ".json"
					local Success, Error = pcall(function()
						if isfile(ThemePath) then
							delfile(ThemePath)
						end
					end)

					if Success then
						Library:RefreshThemeList(Theme_Dropdown)
						NotifySuccessTheme("Succesfully deleted theme: " .. Theme_Selected)
					else
						NotifyErrorTheme("Failed to delete theme: " .. Theme_Selected .. " " .. tostring(Error))
					end
				end)

				ThemeSetting_Section:Button():Add("Load", function()
					if not Theme_Selected then
						NotifyErrorTheme("Please select a theme first")
						return
					end

					local ThemePath = ThemeFolder .. Theme_Selected .. ".json"

					if not isfile(ThemePath) then
						NotifyErrorTheme("Failed to find theme: " .. Theme_Selected)
						return
					end

					local ThemeContent = readfile(ThemePath)
					local Success, Error = Library:LoadTheme(ThemeContent)

					if Success then
						NotifySuccessTheme("Succesfully loaded theme: " .. Theme_Selected)
					else
						NotifyErrorTheme("Failed to load theme: " .. Theme_Selected .. " " .. tostring(Error))
					end
				end):Add("Save", function()
					if not Theme_Selected then
						NotifyErrorTheme("Please select a theme first")
						return
					end

					local ThemePath = ThemeFolder .. Theme_Selected .. ".json"

					if not isfile(ThemePath) then
						NotifyErrorTheme("Failed to find theme: " .. Theme_Selected)
						return
					end

					local Success, Error = pcall(function()
						writefile(ThemePath, Library:GetTheme())
					end)

					if Success then
						NotifySuccessTheme("Succesfully saved theme: " .. Theme_Selected)
					else
						NotifyErrorTheme("Failed to save theme: " .. Theme_Selected .. " " .. tostring(Error))
					end
				end)

				ThemeSetting_Section:Button():Add("Refresh", function()
					Library:RefreshThemeList(Theme_Dropdown)
				end)

				local Preset_Section = ThemeSetting_Section:Dropdown({
					Name = "Themes Preset",
					Flag = "Themes Preset",
					Description = "Select a theme",
					Items = {},
					Default = "Solix",
					Multi = false,
					Callback = function(Value)
						local ThemeData = Library.Themes[Value]

						if not ThemeData then
							return
						end

						for Index, Value in Library.Theme do
							Library.Theme[Index] = ThemeData[Index]
							Library:ChangeTheme(Index, ThemeData[Index])

							Theme_Colorpicker[Index]:Set(ThemeData[Index])
						end
					end,
				})

				for Index in pairs(Library.Themes) do
					Preset_Section:Add(Index)
				end

				Library:RefreshThemeList(Theme_Dropdown)
			end
		end

		do
			local MenuSetting_Section = MenuTab:Section({Name = "Menu Setting", Side = 1})

			MenuSetting_Section:Button():Add("Unload", function()
				Library:Unload()
			end)

			MenuSetting_Section:Label("Menu keybind", "open/close menu keybind"):Keybind({
				Name = "Menu Keybind",
				Flag = "Menu Keybind",
				Default = Enum.KeyCode.RightControl,
				Mode = "Toggle",
				Callback = function()
					Library.MenuKeybind = Library.Flags["Menu Keybind"].Key
					Library:SaveLocalSettings()
				end,
			})

			if Library.Flags["Menu Keybind"] and Library.Flags["Menu Keybind"].Key then
				Library.MenuKeybind = Library.Flags["Menu Keybind"].Key
			end

			MenuSetting_Section:Dropdown({
				Name = "Language",
				Flag = "Menu Language",
				Description = "Select menu language",
				Default = Library.LanguagePreset or "Auto",
				Items = Library.LanguageOptions,
				Callback = function(Value)
					Library:ApplyLanguagePreset(Value)
					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Slider({
				Name = "Background Transparency",
				Flag = "Background Transparency",
				Description = "Menu background transparency",
				Min = 0,
				Max = 1,
				Default = Library.BackgroundTransparency,
				Decimals = 0.01,
				Callback = function(Value)
					Library.BackgroundTransparency = Value
					Window:SetTransparency(Value)
					KeybindList:SetTransparency(Value)
					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Slider({
				Name = "Menu Tween Time",
				Flag = "Menu Tween Time",
				Description = "Menu animation tween time",
				Min = 0,
				Max = 5,
				Default = Library.Tween.Time,
				Decimals = 0.01,
				Callback = function(Value)
					Library.Tween.Time = Value
					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Slider({
				Name = "Menu Fade Time",
				Flag = "Menu Fade Time",
				Description = "Menu fade animation time",
				Min = 0,
				Max = 5,
				Default = Library.FadeSpeed,
				Decimals = 0.01,
				Callback = function(Value)
					Library.FadeSpeed = Value
					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Dropdown({
				Name = "Menu Scale Preset",
				Flag = "Menu Scale Preset",
				Description = "Select Menu scale preset",
				Default = Library.MenuScalePreset or (IsMobile and "Bigger" or "Medium"),
				Items = {"Very Small", "Small", "Medium", "Large", "Bigger", "Massive"},
				Callback = function(Value)
					Library.MenuScalePreset = Value

					if ScaleValues[Value] then
						Library:SetScaleNumeric(ScaleValues[Value])
					end

					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Dropdown({
				Name = "Menu Tween Style",
				Flag = "Menu Tween Style",
				Description = "Menu animation easing style",
				Default = Library.MenuTweenStyle or "Cubic",
				Items = {"Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential", "Circular", "Back", "Elastic", "Bounce"},
				Callback = function(Value)
					Library.MenuTweenStyle = Value
					Library.Tween.Style = Enum.EasingStyle[Value]
					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Dropdown({
				Name = "Menu Tween Direction",
				Flag = "Menu Tween Direction",
				Description = "Menu animation easing direction",
				Default = Library.MenuTweenDirection or "Out",
				Items = {"In", "Out", "InOut"},
				Callback = function(Value)
					Library.MenuTweenDirection = Value
					Library.Tween.Direction = Enum.EasingDirection[Value]
					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Toggle({
				Name = "Show Watermark",
				Flag = "Show Watermark",
				Description = "Show/hide the Watermark",
				Default = Library.ShowWatermark == true,
				Callback = function(Value)
					Library.ShowWatermark = Value == true

					local ActiveWatermark = Watermark or Library.WatermarkInstance

					if ActiveWatermark and ActiveWatermark.SetVisibility then
						ActiveWatermark:SetVisibility(Value == true)
					end

					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Toggle({
				Name = "Show Keybind List",
				Flag = "Show Keybind List",
				Description = "Show/hide list of all keybinds",
				Default = Library.ShowKeybindList == true,
				Callback = function(Value)
					Library.ShowKeybindList = Value == true
					KeybindList:SetVisibility(Value)
					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Toggle({
				Name = "Show Menu Button",
				Flag = "Show Menu Button",
				Description = "Show/hide the menu open button",
				Default = Library.ShowMenuButton ~= false,
				Callback = function(Value)
					Library.ShowMenuButton = Value == true

					if Library.FloatingButtonHolder then
						Library.FloatingButtonHolder.Instance.Enabled = Value
					end

					Library:SaveLocalSettings()
				end,
			})

			MenuSetting_Section:Toggle({
				Name = "Background Darken",
				Flag = "Background Darken",
				Description = "Dark overlay/blur while menu is open",
				Default = Library.BackgroundDarkenEnabled ~= false,
				Callback = function(Value)
					Library:SetBackgroundDarkenEnabled(Value)
				end,
			})

			MenuSetting_Section:Dropdown({
				Name = "Background Effect",
				Flag = "Background Effect",
				Description = "Particle effect behind the menu",
				Default = Library.BackgroundEffect or "Snow",
				Items = Library.BackgroundEffectOptions,
				Callback = function(Value)
					Library:SetBackgroundEffect(Value)
				end,
			})

			MenuSetting_Section:Toggle({
				Name = "Auto Save Config",
				Flag = "Auto Save Config",
				Description = "Automatically save your config",
				Default = Library.AutoSave == true,
				Callback = function(Value)
					Library.AutoSave = Value
				end,
			})

			MenuSetting_Section:Toggle({
				Name = "Safe Mode",
				Flag = "Safe Mode",
				Description = "Auto Hides Ui On Execute",
				Default = Library.SafeMode == true,
				Callback = function(Value)
					Library.SafeMode = Value
					Library:SaveLocalSettings()

					if Value then
						Window:SetOpen(false)

						if Library.FloatingButtonHolder then
							Library.FloatingButtonHolder.Instance.Enabled = Library.ShowMenuButton ~= false
						end
					end
				end,
			})

			MenuSetting_Section:Toggle({
				Name = "Auto Execute",
				Flag = "Auto Execute",
				Description = "Auto execute script after teleport",
				Default = Library.AutoExecute == true,
				Callback = function(Value)
					Library.AutoExecute = Value
					Library:SaveLocalSettings()

					if Value and not getgenv().auto_execute then
						getgenv().auto_execute = true
						task.wait(0.3)
						queueonteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/bao8jl/solixhub/main/loader"))()')
					end
				end,
			})

			Library:CreateFontSettingsSection(MenuTab, {
				Name = "Font",
				Side = 2,
			})

			Library:ApplyMenuSettingsFromLocal(Watermark, KeybindList, Window)
		end

		do
			local Server_Section = ConfigsTab:Section({Name = "Server", Side = 1})
			local TeleportService = cloneref(game:GetService("TeleportService"))
			local HttpService = cloneref(game:GetService("HttpService"))

			local function CopyToClipboard(Text)
				pcall(function()
					setclipboard(Text)
				end)
			end

			local function NotifyGame(Message, Color)
				Library:Notification({
					Name = "Server",
					Description = Message,
					Color = Color or Color3.fromRGB(100, 255, 100),
					Duration = 3,
				})
			end

			Server_Section:Button():Add("Rejoin", function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
				NotifyGame("Rejoining...")
			end):Add("Server Hop", function()
				local Servers = {}
				local Success, Result = pcall(function()
					return HttpService:GetAsync(
						"https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
					)
				end)

				if Success and Result then
					local Data = HttpService:JSONDecode(Result)

					for _, Server in Data.data or {} do
						if Server.id ~= game.JobId and Server.playing < Server.maxPlayers then
							TableInsert(Servers, Server.id)
						end
					end
				end

				if #Servers > 0 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1, #Servers)], LocalPlayer)
					NotifyGame("Server hopping...")
				else
					TeleportService:Teleport(game.PlaceId, LocalPlayer)
					NotifyGame("No servers found, joining a new server", Color3.fromRGB(255, 200, 100))
				end
			end)

			Server_Section:Button():Add("Copy Place ID", function()
				CopyToClipboard(tostring(game.PlaceId))
				NotifyGame("Place ID copied")
			end):Add("Copy Game ID", function()
				CopyToClipboard(tostring(game.GameId))
				NotifyGame("Game ID copied")
			end)

			Server_Section:Button():Add("Copy Job ID", function()
				CopyToClipboard(tostring(game.JobId))
				NotifyGame("Job ID copied")
			end):Add("Copy Join Code", function()
				CopyToClipboard(
					'cloneref(game:GetService("TeleportService"):TeleportToPlaceInstance('
						.. game.PlaceId
						.. ', "'
						.. game.JobId
						.. '"))'
				)
				NotifyGame("Join code copied")
			end)
		end

		do
			local ScriptConfig_Section = ConfigsTab:Section({Name = "Script Config", Side = 2})

			local ConfigFolder = Library:GetFolder()
			local AutoloadPath = GetAutoloadPath()

			local function NotifySuccessConfig(Message)
				Library:Notification({
					Name = "Success",
					Description = Message,
					Color = Color3.fromRGB(0, 255, 0),
					Duration = 5
				})
			end

			local function NotifyErrorConfig(Message)
				Library:Notification({
					Name = "Error",
					Description = Message,
					Color = Color3.fromRGB(255, 0, 0),
					Duration = 5
				})
			end

			do
				local Config_Name
				local Config_Selected

				local Config_Dropdown = ScriptConfig_Section:Dropdown({
					Name = "Config Select",
					Flag = "Config Select",
					Description = "List of the Configurations",
					Items = {},
					Multi = false,
					Callback = function(Value)
						Config_Selected = Value

						if Library.AutoloadConfigEnabled and Config_Selected and Config_Selected ~= "" then
							pcall(function()
								writefile(GetAutoloadConfigNamePath(), Config_Selected)
							end)
						end
					end
				})

				ScriptConfig_Section:Toggle({
					Name = "Autoload Configuration",
					Flag = "Autoloads the selected configuration on next load",
					Description = "Autoloads the selected configuration on next load",
					Default = Library.AutoloadConfigEnabled == true,
					Callback = function(Value)
						Library.AutoloadConfigEnabled = Value
						Library:SaveLocalSettings()

						if Value and Config_Selected and Config_Selected ~= "" then
							pcall(function()
								writefile(GetAutoloadConfigNamePath(), Config_Selected)
							end)
						elseif not Value then
							pcall(function()
								if isfile(GetAutoloadConfigNamePath()) then
									delfile(GetAutoloadConfigNamePath())
								end
							end)
						end
					end,
				})

				ScriptConfig_Section:Textbox({
					Name = "Config Name",
					Flag = "Config Name",
					Description = "Name of the config",
					Placeholder = "Config name...",
					Finished = false,
					Callback = function(Value)
						Config_Name = Value
					end
				})

				ScriptConfig_Section:Button():Add("Create", function()
					if not Config_Name or Config_Name == "" then
						return
					end

					local Success, Error = pcall(function()
						writefile(ConfigFolder .. Config_Name .. ".json", Library:GetConfig())
					end)

					if Success then
						Library:RefreshConfigsList(Config_Dropdown)
						NotifySuccessConfig("Succesfully created config: " .. Config_Name)
					else
						NotifyErrorConfig("Failed to create config: " .. Config_Name .. " " .. tostring(Error))
					end
				end):Add("Delete", function()
					if not Config_Selected then
						NotifyErrorConfig("Please select a config first")
						return
					end

					local ConfigPath = ConfigFolder .. Config_Selected .. ".json"
					local Success, Error = pcall(function()
						if isfile(ConfigPath) then
							delfile(ConfigPath)
						end
					end)

					if Success then
						Library:RefreshConfigsList(Config_Dropdown)
						NotifySuccessConfig("Succesfully deleted config: " .. Config_Selected)
					else
						NotifyErrorConfig("Failed to delete config: " .. Config_Selected .. " " .. tostring(Error))
					end
				end)

				ScriptConfig_Section:Button():Add("Load", function()
					if not Config_Selected then
						NotifyErrorConfig("Please select a config first")
						return
					end

					local ConfigPath = ConfigFolder .. Config_Selected .. ".json"

					if not isfile(ConfigPath) then
						NotifyErrorConfig("Failed to find config: " .. Config_Selected)
						return
					end

					local ConfigContent = readfile(ConfigPath)
					local Success, Error = Library:LoadConfig(ConfigContent)

					if Success then
						NotifySuccessConfig("Succesfully loaded config: " .. Config_Selected)
					else
						NotifyErrorConfig("Failed to load config: " .. (Config_Selected or "Unknown") .. " " .. tostring(Error))
					end
				end):Add("Save", function()
					if not Config_Selected then
						NotifyErrorConfig("Please select a config first")
						return
					end

					local ConfigPath = ConfigFolder .. Config_Selected .. ".json"

					if not isfile(ConfigPath) then
						NotifyErrorConfig("Failed to find config: " .. Config_Selected)
						return
					end

					local Success, Error = pcall(function()
						writefile(ConfigPath, Library:GetConfig())
					end)

					if Success then
						NotifySuccessConfig("Succesfully saved config: " .. Config_Selected)
					else
						NotifyErrorConfig("Failed to save config: " .. Config_Selected .. " " .. tostring(Error))
					end
				end)

				ScriptConfig_Section:Button():Add("Refresh", function()
					Library:RefreshConfigsList(Config_Dropdown)
				end)

				ScriptConfig_Section:Button():Add("Set Autoload", function()
					local Success, Error = pcall(function()
						writefile(AutoloadPath, Library:GetConfig())
					end)

					if Success then
						NotifySuccessConfig("Autoload set to current config")
					else
						NotifyErrorConfig("Failed to set autoload: " .. tostring(Error))
					end
				end):Add("Remove Autoload", function()
					local Success, Error = pcall(function()
						writefile(AutoloadPath, "")
					end)

					if Success then
						NotifySuccessConfig("Succesfully removed autoload")
					else
						NotifyErrorConfig("Failed to remove autoload: " .. tostring(Error))
					end
				end)

				local Pasted_Config = ""

				ScriptConfig_Section:Textbox({
					Name = "Paste Shared Config",
					Flag = "Paste Shared Config",
					Description = "Press Enter after pasting!",
					Placeholder = "Paste config here...",
					Finished = true,
					Callback = function(Value)
						Pasted_Config = Value
					end
				})

				ScriptConfig_Section:Button():Add("Share Config", function()
					local CurrentConfig = Library:GetConfig()

					local Success, Error = pcall(setclipboard, CurrentConfig:gsub('https://discord%.com/api/webhooks/%d+/%S+', ''))

					if Success then
						NotifySuccessConfig("Config copied to clipboard (webhooks removed)")
					else
						NotifyErrorConfig("Failed to copy config: " .. tostring(Error))
					end
				end):Add("Import Pasted", function()
					if not Pasted_Config or Pasted_Config == "" then
						NotifyErrorConfig("No config pasted")
						return
					end

					local Success, Error = Library:LoadConfig(Pasted_Config:gsub('https://discord%.com/api/webhooks/%d+/%S+', ''))

					if Success then
						NotifySuccessConfig("Succesfully imported config (webhooks removed)")
					else
						NotifyErrorConfig("Failed to import config: " .. tostring(Error))
					end
				end)

				Library:RefreshConfigsList(Config_Dropdown)
			end
		end

		Library:FinalizeMenuSettings(Watermark, KeybindList, Window)

		return Settings
	end
end

getgenv().Library = Library

task.defer(function()
	pcall(function()
		Library.Localization:ReloadRemoteTranslations()
	end)

	pcall(function()
		Library.Localization:Init()
	end)
end)

return Library
