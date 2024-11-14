<?php

use App\Http\Controllers\Master\ProjectController;
use Illuminate\Support\Facades\Route;

Route::prefix('master')->name('master.')->group(function () {
    // PROJECTS
    Route::prefix('projects')->name('projects.')->group(function () {
        Route::get('data', [ProjectController::class, 'data'])->name('data');
        Route::resource('/', ProjectController::class)->parameters(['' => 'project']);
        Route::post('/update-many', [ProjectController::class, 'updateMany'])->name('updateMany');
    });
});
