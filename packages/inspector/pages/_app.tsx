import "../styles/global.css";

type AppProps = {
  Component: React.FC;
  pageProps: any;
};

export default function App({ Component, pageProps }: AppProps) {
  return (
    <main>
      <Component {...pageProps} />
    </main>
  );
}
