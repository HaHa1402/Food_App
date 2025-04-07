// 🆕 Thêm block buildscript vào đầu file:
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
    repositories {
        google()
        mavenCentral()
    }
}

// Phần còn lại giữ nguyên
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = File(rootDir, "../build")

subprojects {
    project.buildDir = File(rootProject.buildDir, project.name)

    val newSubprojectBuildDir = project.buildDir
    // Nếu bạn cần xài newSubprojectBuildDir ở đâu đó thì dùng biến này.
}

rootProject.buildDir = File(rootDir, "../build")

subprojects {
    project.buildDir = File(rootProject.buildDir, project.name)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
