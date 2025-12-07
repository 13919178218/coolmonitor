-- CreateTable
CREATE TABLE "MonitorGroup" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "color" TEXT,
    "displayOrder" INTEGER,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "createdById" TEXT,
    CONSTRAINT "MonitorGroup_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Monitor" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "config" JSONB NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "interval" INTEGER NOT NULL DEFAULT 60,
    "retries" INTEGER NOT NULL DEFAULT 0,
    "retryInterval" INTEGER NOT NULL DEFAULT 60,
    "resendInterval" INTEGER NOT NULL DEFAULT 0,
    "upsideDown" BOOLEAN NOT NULL DEFAULT false,
    "description" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "createdById" TEXT,
    "lastCheckAt" DATETIME,
    "nextCheckAt" DATETIME,
    "lastStatus" INTEGER,
    "displayOrder" INTEGER,
    "groupId" TEXT,
    CONSTRAINT "Monitor_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Monitor_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "MonitorGroup" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Monitor" ("active", "config", "createdAt", "createdById", "description", "displayOrder", "id", "interval", "lastCheckAt", "lastStatus", "name", "nextCheckAt", "resendInterval", "retries", "retryInterval", "type", "updatedAt", "upsideDown") SELECT "active", "config", "createdAt", "createdById", "description", "displayOrder", "id", "interval", "lastCheckAt", "lastStatus", "name", "nextCheckAt", "resendInterval", "retries", "retryInterval", "type", "updatedAt", "upsideDown" FROM "Monitor";
DROP TABLE "Monitor";
ALTER TABLE "new_Monitor" RENAME TO "Monitor";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
