import { CurrentAccountProvider } from '@/context/CurrentAccountProvider'
import '@/styles/globals.css'
import type { AppProps } from 'next/app'


export default function MyApp({ Component, pageProps }: AppProps) {
  return (
    <CurrentAccountProvider>
      <Component {...pageProps} />
    </CurrentAccountProvider>
  )
}
