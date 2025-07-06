<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>
    </head>
    <body class="antialiased">

    <div>
        <p>สถานะ: {{ $status }}</p>
        <p>test: {{ $test }}</p>
        <p>message: {{ $message }}</p>
        {{-- <p>data: {{ $data }}</p> --}}
    </div>

    {{-- @for ($i = $data['CurrentDateTime']; $i > $data['EndDateTime']; $i++) --}}
        <div>
            <p>{{ $data['CurrentDateTime'] }}</p>
        </div>
    {{-- @endfor --}}




    </body>
</html>
