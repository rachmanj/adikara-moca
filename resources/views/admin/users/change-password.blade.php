@extends('layout.main')

@section('title_page')
    Change Password
@endsection

@section('breadcrumb_title')
    users
@endsection

@section('content')
    <form action="{{ route('admin.users.password_update', ['id' => auth()->user()->id]) }}" method="POST">
        @csrf @method('PUT')
        <div class="row">

            <div class="col-7">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">Change Password</div>
                        <a href="{{ route('home') }}" class="btn btn-sm btn-primary float-right"><i
                                class="fas fa-arrow-left"></i> Back</a>
                    </div>

                    <div class="card-body">

                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" name="password"
                                        class="form-control @error('password') is-invalid @enderror">
                                    @error('password')
                                        <div class="invalid-feedback">
                                            {{ $message }}
                                        </div>
                                    @enderror
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="password_confirmation">Password Confirmation</label>
                                    <input type="password" name="password_confirmation"
                                        class="form-control @error('password_confirmation') is-invalid @enderror">
                                    @error('password_confirmation')
                                        <div class="invalid-feedback">
                                            {{ $message }}
                                        </div>
                                    @enderror
                                </div>
                            </div>
                        </div>

                        <div class="card-footer">
                            <button type="submit" class="btn btn-sm btn-primary btn-block"><i class="fas fa-save"></i>
                                Save</button>
                        </div>

                    </div>
                </div>
            </div> {{-- col-7 --}}

        </div> {{-- row --}}
    </form>
@endsection
