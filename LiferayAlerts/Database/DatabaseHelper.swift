/**
 * Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

import CoreData
import Foundation

/**
 * @author Silvio Santos
 */
class DatabaseHelper {

	class func getInstance() -> DatabaseHelper {
		return DatabaseHelper._instance
	}

	func commit() {
		if (_context == nil) {
			NSLog("Coldn't save data: Context is nil")

			return
		}

		var error: NSError? = nil

		if (!_context!.hasChanges) {
			return
		}

		if (!_context!.save(&error)) {
			NSLog("Unresolved error \(error), \(error!.userInfo)")
		}
	}

	func getContext() -> NSManagedObjectContext? {
		return _context
	}

	private func _initContext() -> NSManagedObjectContext? {
		if (_storeCoordinator == nil) {
			return nil
		}

		var context = NSManagedObjectContext()
		context.persistentStoreCoordinator = _storeCoordinator

		return context
	}

	private func _initDocumentsDirectory() -> NSURL {
		var manager: NSFileManager = NSFileManager.defaultManager()
		var urls = manager.URLsForDirectory(
			.DocumentDirectory, inDomains:.UserDomainMask)

		var url = urls[urls.count-1] as NSURL

		return url
	}

	private func _initManagedObjectModel() -> NSManagedObjectModel {
		var bundle : NSBundle = NSBundle.mainBundle()
		var modelURL = bundle.URLForResource("Model", withExtension: "momd")!

		return NSManagedObjectModel(contentsOfURL:modelURL)!
	}

	private func _initPersistentStoreCordinator()
		-> NSPersistentStoreCoordinator? {

		var storeCoordinator: NSPersistentStoreCoordinator? =
			NSPersistentStoreCoordinator(managedObjectModel:_managedObjectModel)

		var url = _documentsDirectory.URLByAppendingPathComponent(DATABASE_NAME)
		var error: NSError? = nil

		var store: NSPersistentStore? =
			storeCoordinator!.addPersistentStoreWithType(
			NSSQLiteStoreType, configuration:nil, URL:url, options:nil,
			error:&error)

		if (store == nil) {
			storeCoordinator = nil

			NSLog("Unresolved error \(error), \(error!.userInfo)")
		}

		return storeCoordinator
	}

	private class var _instance : DatabaseHelper {
		struct Static {
			static let _instance : DatabaseHelper = DatabaseHelper()
		}

		return Static._instance
	}

	private lazy var _context: NSManagedObjectContext? = self._initContext()
	private lazy var _documentsDirectory: NSURL = self._initDocumentsDirectory()
	private lazy var _managedObjectModel: NSManagedObjectModel =
		self._initManagedObjectModel()

	private lazy var _storeCoordinator: NSPersistentStoreCoordinator? =
		self._initPersistentStoreCordinator()

	let DATABASE_NAME: String = "liferay-alerts.db"
}
