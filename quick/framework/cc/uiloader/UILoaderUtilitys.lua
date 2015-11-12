
local UILoaderUtilitys = {}

function UILoaderUtilitys.loadTexture(plist, png)
	if UILoaderUtilitys.isNil(plist) then
		return
	end

	-- 先判断该plist是否已经加载,若已经加载则不用再加载(避免热更新后新资源和本地资源重复加载)
	-- 调用UILoaderUtilitys.getFilePath获取plistFile的路径,先从device.writablePath读取,若该文件不存在,再从本地读取
	-- 需要device.writablePath下的文件夹结构和项目文件夹一致
	-- 方便热更新后,新的plist放在device.writablePath,而该接口从本地读取覆盖热更新的资源
	-- 2015/10/27 tokimi	

	plist = UILoaderUtilitys.getFilePath(plist)

	local spCache
	spCache = cc.SpriteFrameCache:getInstance()	

	if spCache:isSpriteFramesWithFileLoaded(plist) then
		--已预先加载,不做处理
	else
		--尚未加载,加载图片
		local fileUtil
		fileUtil = cc.FileUtils:getInstance()
		local fullPath = fileUtil:fullPathForFilename(plist)
		local fullPng = fileUtil:fullPathForFilename(png)
		-- UILoaderUtilitys.addSearchPathIf(io.pathinfo(fullPath).dirname, fileUtil)
		-- local spCache
		-- spCache = cc.SpriteFrameCache:getInstance()
		-- print("UILoaderUtilitys - loadTexture plist:" .. plist)
		if png then
			spCache:addSpriteFrames(fullPath, fullPng)
		else
			spCache:addSpriteFrames(fullPath)
		end
	end
end

function UILoaderUtilitys.isNil(str)
	if not str or 0 == string.utf8len(str) then
		return true
	else
		return false
	end
end

function UILoaderUtilitys.addSearchPathIf(dir, fileUtil)
	if not fileUtil then
        fileUtil = cc.FileUtils:getInstance()
    end
    -- 判断是不是已经存在的默认路径
    local paths = fileUtil:getSearchPaths()
    for i=1, #(paths) do
        if paths[i] == dir then
            return
        end
    end

	if not UILoaderUtilitys.searchDirs then
		UILoaderUtilitys.searchDirs = {}
	end

	if not UILoaderUtilitys.isSearchExist(dir) then
		table.insert(UILoaderUtilitys.searchDirs, dir)
		if not fileUtil then
			fileUtil = cc.FileUtils:getInstance()
		end
		fileUtil:addSearchPath(dir)
	end
end

function UILoaderUtilitys.isSearchExist(dir)
	local bExist = false
	for i,v in ipairs(UILoaderUtilitys.searchDirs) do
		if v == dir then
			bExist = true
			break
		end
	end

	return bExist
end

function UILoaderUtilitys.clearPath(fileUtil)
	if not UILoaderUtilitys.searchDirs then
		return
	end

	fileUtil = fileUtil or cc.FileUtils:getInstance()
	local paths = fileUtil:getSearchPaths()
	local removeIdxTabel

	local luaSearchCount = #UILoaderUtilitys.searchDirs

	for i=luaSearchCount, 1, -1 do
		for key, path in ipairs(paths) do
			if path == UILoaderUtilitys.searchDirs[i] then
				table.remove(paths, key)
				break
			end
		end
		table.remove(UILoaderUtilitys.searchDirs, i)
	end

	paths = table.unique(paths, true)

	fileUtil:setSearchPaths(paths)
end

function UILoaderUtilitys.getFileFullName(filename)
	local fileUtil = fileUtil or cc.FileUtils:getInstance()

	return fileUtil:fullPathForFilename(filename)
end

-- 获取plistFile的路径,先从device.writablePath读取,若该文件不存在,再从本地读取
-- 方便热更新后,新的plist放在device.writablePath,而该接口从本地读取覆盖热更新的资源
-- 2015/10/27 tokimi
function UILoaderUtilitys.getFilePath(fileName)
    if cc.FileUtils:getInstance():isFileExist(device.writablePath.."/"..fileName) then
        fileName = device.writablePath..fileName 
    end
    
    return fileName
end

return UILoaderUtilitys

