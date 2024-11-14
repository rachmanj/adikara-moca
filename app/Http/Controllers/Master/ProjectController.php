<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use App\Models\Project;
use RealRashid\SweetAlert\Facades\Alert;
use Illuminate\Http\Request;

class ProjectController extends Controller
{
    public function index()
    {
        return view('master.projects.index');
    }

    public function data()
    {
        $projects = Project::orderBy('code', 'asc')
            ->whereNull('name')
            ->get();

        return datatables()->of($projects)
            ->addIndexColumn()
            ->addColumn('action', 'master.projects.action')
            ->rawColumns(['action'])
            ->toJson();
    }

    public function updateMany(Request $request)
    {
        $projectIds = explode(',', $request->input('project_ids'));
        $newName = $request->input('new_name');

        Project::whereIn('id', $projectIds)->update(['name' => $newName]);

        Alert::success('Proyek berhasil diperbarui.');

        return response()->json(['success' => 'Proyek berhasil diperbarui.']);
    }
}
