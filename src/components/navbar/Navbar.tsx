import type { FC } from 'react'

export const Navbar: FC = () => {
  return (
    <header className="mt-1 mb-5 px-2">
      <div className="w-full flex items-center justify-center gap-2 -ml-3">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          xmlSpace="preserve"
          viewBox="0 0 32 32"
          className="w-6 h-6"
        >
          <g fill="#fff">
            <path d="M1.836 23.001A4.963 4.963 0 0 0 .108 26.56a4.957 4.957 0 0 0 1.435 3.687 4.912 4.912 0 0 0 3.504 1.457 4.946 4.946 0 0 0 3.716-1.681l6.626-7.474 7.739 7.739a4.819 4.819 0 0 0 3.429 1.421c1.296 0 2.514-.505 3.43-1.421s1.421-2.134 1.421-3.43a4.819 4.819 0 0 0-1.421-3.429l-8.152-8.152 2.042-2.303a6.743 6.743 0 0 0 1.848.259c1.903 0 3.659-.817 4.818-2.242 1.601-1.967 1.8-4.746.507-7.08-.291-.524-1.166-.503-1.443.031l-1.473 2.837c-.354.683-1.248.967-1.937.612l-1.502-.782a1.42 1.42 0 0 1-.707-.84 1.426 1.426 0 0 1 .094-1.094l1.66-3.188a.817.817 0 0 0-.025-.804c-.146-.242-.401-.39-.75-.392-1.903 0-3.66.816-4.819 2.241-1.285 1.579-1.679 3.691-1.079 5.712l-5.612 4.806-7.718-7.716a2.613 2.613 0 0 0 .341-2.322 2.724 2.724 0 0 0-2.047-1.835L1.97.744a1.286 1.286 0 0 0-1.177.351c-.309.309-.44.749-.351 1.177l.433 2.063a2.76 2.76 0 0 0 2.69 2.186c.537 0 1.038-.166 1.476-.47l7.653 7.653-10.858 9.297zM3.565 5.538c-.706 0-1.521-.46-1.712-1.373l-.432-2.029c-.02-.096.01-.126.079-.195.05-.05.115.059.23.059h.034l2.063.295c.617.129 1.104.429 1.303 1.032.189.573.067 1.18-.319 1.616l-.168.173c-.304.27-.677.422-1.078.422zm25.714 18.599a3.82 3.82 0 0 1 1.128 2.722c0 1.029-.4 1.996-1.128 2.723-1.452 1.455-3.99 1.455-5.444 0L16.053 21.8l5.117-5.772 8.109 8.109zM20.118 8.242c-.63-1.786-.329-3.685.805-5.078C21.83 2.05 23.18 1.38 24.712 1.3l-1.518 2.914c-.299.578-.356 1.237-.16 1.857s.623 1.127 1.2 1.426l1.502.782c.347.179.733.273 1.121.273A2.43 2.43 0 0 0 29.02 7.24l1.315-2.533c.913 1.905.703 4.091-.568 5.653-1.347 1.654-3.753 2.286-5.891 1.567a.504.504 0 0 0-.534.142L8.013 29.36a3.945 3.945 0 0 1-5.761.181c-.783-.787-1.189-1.832-1.145-2.941s.534-2.117 1.379-2.839L19.972 8.788a.5.5 0 0 0 .146-.546z" />
            <path d="m19.877 21.033 6.026 6.026a.498.498 0 0 0 .708 0 .5.5 0 0 0 0-.707l-6.026-6.026a.5.5 0 0 0-.708.707zM5.065 24.769c-1.103 0-2 .897-2 2s.897 2 2 2 2-.897 2-2-.897-2-2-2zm0 3a1 1 0 1 1 0-2 1 1 0 0 1 0 2z" />
          </g>
        </svg>

        <h1 className="text-2xl font-bold text-white text-center">
          Ferretería JR
        </h1>
      </div>
    </header>
  )
}
